import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';
import '../../data/services/api_service.dart';
import '../../data/services/sync_service.dart';
import '../../core/constants/app_constants.dart';
import 'package:logger/logger.dart';

// ─── Repositories ────────────────────────────────────────────────────────────

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final reportRepositoryProvider = Provider<ReportRepository>((ref) {
  return ReportRepository(ref.read(apiServiceProvider));
});

final alertRepositoryProvider = Provider<AlertRepository>((ref) {
  return AlertRepository(ref.read(apiServiceProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(apiServiceProvider));
});

final beneficiaryRepositoryProvider = Provider<BeneficiaryRepository>((ref) {
  return BeneficiaryRepository(ref.read(apiServiceProvider));
});

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(
    ref.read(reportRepositoryProvider),
    ref.read(beneficiaryRepositoryProvider),
  );
});

final wardsProvider = FutureProvider<List<Map<String, String>>>((ref) async {
  return ref.read(beneficiaryRepositoryProvider).fetchWards();
});

final facilitiesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return ref.read(beneficiaryRepositoryProvider).fetchFacilities();
});

// ─── Auth Provider ────────────────────────────────────────────────────────────

class AuthNotifier extends StateNotifier<AshaWorker?> {
  final AuthRepository _repo;
  final SharedPreferences _prefs;

  AuthNotifier(this._repo, this._prefs) : super(null) {
    _loadSavedUser();
    // Listen to Firebase auth changes automatically
    _repo.authStateChanges.listen((user) async {
      if (user == null || !user.emailVerified) {
        state = null;
        await _prefs.remove(AppConstants.userKey);
      } else {
        // Map Firebase User to our App Model
        final worker = AshaWorker(
          id: user.uid,
          username: user.email ?? 'user',
          fullName: user.displayName ?? 'ASHA Worker',
          wardCode: 'W01',
          wardName: 'SMC Solapur',
          phone: user.phoneNumber ?? '',
          role: 'asha',
        );
        state = worker;
        await _prefs.setString(AppConstants.userKey, jsonEncode(worker.toJson()));
      }
    });
  }

  void _loadSavedUser() {
    final userJson = _prefs.getString(AppConstants.userKey);
    if (userJson != null) {
      try {
        state = AshaWorker.fromJson(jsonDecode(userJson));
      } catch (_) {
        state = null;
      }
    }
  }

  // --- [Firebase Step 1: Login with Email & Password] ---
  Future<bool> login(String email, String password) async {
    final worker = await _repo.login(email, password);
    if (worker != null) {
      state = worker;
      // Persistence handled by authStateChanges listener
      await _prefs.setString(AppConstants.userKey, jsonEncode(worker.toJson()));
      return true;
    }
    return false;
  }

  // --- [Firebase Step 2: Register & Verify] ---
  Future<void> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    await _repo.registerAndVerify(
      email: email, 
      password: password, 
      fullName: fullName
    );
  }

  Future<void> logout() async {
    await _repo.signOut();
    state = null;
    await _prefs.remove(AppConstants.userKey);
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in ProviderScope overrides',
  );
});

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AshaWorker?>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return AuthNotifier(
    ref.read(authRepositoryProvider),
    prefs,
  );
});

final currentWorkerProvider = Provider<AshaWorker?>((ref) {
  return ref.watch(authNotifierProvider);
});

// ─── Report Providers ─────────────────────────────────────────────────────────

final todaysReportsProvider = FutureProvider<List<AshaReport>>((ref) async {
  final worker = ref.watch(currentWorkerProvider);
  if (worker == null) return [];
  return ref.read(reportRepositoryProvider).getTodaysReports(worker.id);
});

final allReportsProvider = FutureProvider<List<AshaReport>>((ref) async {
  final worker = ref.watch(currentWorkerProvider);
  if (worker == null) return [];
  return ref.read(reportRepositoryProvider).getReportsByWorker(worker.id);
});

final pendingReportsProvider = FutureProvider<List<AshaReport>>((ref) async {
  return ref.read(reportRepositoryProvider).getPendingReports();
});

final pendingCountProvider = FutureProvider<int>((ref) async {
  return ref.read(reportRepositoryProvider).getPendingCount();
});

// ─── Alert Providers ──────────────────────────────────────────────────────────

final alertsProvider = FutureProvider<List<AlertModel>>((ref) async {
  return ref.read(alertRepositoryProvider).getAllAlerts();
});

final unreadCountProvider = FutureProvider<int>((ref) async {
  return ref.read(alertRepositoryProvider).getUnreadCount();
});

// ─── Beneficiary Providers ───────────────────────────────────────────────────

final familiesProvider = FutureProvider<List<FamilyModel>>((ref) async {
  final worker = ref.watch(currentWorkerProvider);
  if (worker == null) return [];
  return ref.read(beneficiaryRepositoryProvider).getFamiliesByWard(worker.wardCode);
});

final beneficiarySearchQueryProvider = StateProvider<String>((ref) => '');

final filteredFamiliesProvider = Provider<AsyncValue<List<FamilyModel>>>((ref) {
  final familiesAsync = ref.watch(familiesProvider);
  final query = ref.watch(beneficiarySearchQueryProvider).toLowerCase();

  return familiesAsync.whenData((families) {
    if (query.isEmpty) return families;
    return families.where((f) =>
      f.familyName.toLowerCase().contains(query) ||
      f.headOfFamily.toLowerCase().contains(query) ||
      f.phoneNumber.contains(query)
    ).toList();
  });
});

final highRiskFamiliesProvider = Provider<AsyncValue<List<FamilyModel>>>((ref) {
  final familiesAsync = ref.watch(familiesProvider);
  return familiesAsync.whenData((families) {
    return families.where((f) {
      return f.members.any((m) => m.children.any((c) => c.nutritionStatus != 'normal')) ||
          (f.lastVisit != null && DateTime.now().difference(f.lastVisit!).inDays > 30);
    }).toList();
  });
});

final pregnantMothersProvider = Provider<AsyncValue<List<BeneficiaryModel>>>((ref) {
  final familiesAsync = ref.watch(familiesProvider);
  return familiesAsync.whenData((families) {
    final mothers = <BeneficiaryModel>[];
    for (final f in families) {
       mothers.addAll(f.members.where((m) => m.pregnancyStatus == 'pregnant'));
    }
    return mothers;
  });
});

final childrenUnderFiveProvider = Provider<AsyncValue<List<ChildProfileModel>>>((ref) {
  final familiesAsync = ref.watch(familiesProvider);
  return familiesAsync.whenData((families) {
    final children = <ChildProfileModel>[];
    for (final f in families) {
      for (final m in f.members) {
        children.addAll(m.children.where((c) => c.ageYears < 5));
      }
    }
    return children;
  });
});

final beneficiaryDetailProvider = FutureProvider.family<BeneficiaryModel?, String>((ref, id) async {
  return ref.read(beneficiaryRepositoryProvider).getBeneficiaryById(id);
});

final familyDetailProvider = FutureProvider.family<FamilyModel?, String>((ref, familyId) async {
  return ref.read(beneficiaryRepositoryProvider).getFamilyById(familyId);
});

final visitsByBeneficiaryProvider = FutureProvider.family<List<Map<String, dynamic>>, String>((ref, beneficiaryId) async {
  return ref.read(beneficiaryRepositoryProvider).getVisitsByBeneficiary(beneficiaryId);
});

final vaccinationsByBeneficiaryProvider = FutureProvider.family<List<Map<String, dynamic>>, String>((ref, beneficiaryId) async {
  return ref.read(beneficiaryRepositoryProvider).getVaccinationsByBeneficiary(beneficiaryId);
});

// ─── Growth Chart Providers ──────────────────────────────────────────────────

final childMeasurementsProvider = FutureProvider.family<List<GrowthMeasurementModel>, String>((ref, childId) async {
  return ref.read(beneficiaryRepositoryProvider).getMeasurementsByChild(childId);
});

// ─── Sync Notifier ────────────────────────────────────────────────────────────

enum SyncState { idle, syncing, done, error }

class SyncNotifier extends StateNotifier<SyncState> {
  final ReportRepository _reportRepo;
  final SharedPreferences _prefs;
  final Ref _ref;

  SyncNotifier(this._reportRepo, this._prefs, this._ref) : super(SyncState.idle);

  DateTime? get lastSynced {
    final ts = _prefs.getString(AppConstants.lastSyncKey);
    return ts != null ? DateTime.tryParse(ts) : null;
  }

  Future<void> syncNow() async {
    if (state == SyncState.syncing) return;

    state = SyncState.syncing;
    try {
      final syncService = _ref.read(syncServiceProvider);
      await syncService.syncAll();

      await _prefs.setString(
          AppConstants.lastSyncKey, DateTime.now().toIso8601String());

      state = SyncState.done;
      
      // Invalidate providers to refresh UI immediately
      _ref.invalidate(todaysReportsProvider);
      _ref.invalidate(allReportsProvider);
      _ref.invalidate(pendingReportsProvider);
      _ref.invalidate(pendingCountProvider);
      
      await Future.delayed(const Duration(seconds: 2));
      state = SyncState.idle;
    } catch (e) {
      state = SyncState.error;
      await Future.delayed(const Duration(seconds: 3));
      state = SyncState.idle;
    }
  }
}

final syncNotifierProvider =
    StateNotifierProvider<SyncNotifier, SyncState>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return SyncNotifier(ref.read(reportRepositoryProvider), prefs, ref);
});

// ─── Report Wizard State ───────────────────────────────────────────────────────

class ReportWizardState {
  final int currentStep;
  final SyndromicData syndromic;
  final MaternalHealthData maternal;
  final ChildHealthData child;
  final EnvironmentalData environmental;
  final GeoLocation? location;
  final List<String> photoPaths;
  final bool isSubmitting;
  final bool isSubmitted;
  final String? error;

  final String? wardCode;

  const ReportWizardState({
    this.currentStep = 0,
    this.syndromic = const SyndromicData(),
    this.maternal = const MaternalHealthData(),
    this.child = const ChildHealthData(),
    this.environmental = const EnvironmentalData(),
    this.location,
    this.photoPaths = const [],
    this.isSubmitting = false,
    this.isSubmitted = false,
    this.error,
    this.wardCode,
  });

  ReportWizardState copyWith({
    int? currentStep,
    SyndromicData? syndromic,
    MaternalHealthData? maternal,
    ChildHealthData? child,
    EnvironmentalData? environmental,
    GeoLocation? location,
    List<String>? photoPaths,
    bool? isSubmitting,
    bool? isSubmitted,
    String? error,
    String? wardCode,
  }) {
    return ReportWizardState(
      currentStep: currentStep ?? this.currentStep,
      syndromic: syndromic ?? this.syndromic,
      maternal: maternal ?? this.maternal,
      child: child ?? this.child,
      environmental: environmental ?? this.environmental,
      location: location ?? this.location,
      photoPaths: photoPaths ?? this.photoPaths,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      error: error ?? this.error,
      wardCode: wardCode ?? this.wardCode,
    );
  }
}

class ReportWizardNotifier extends StateNotifier<ReportWizardState> {
  final ReportRepository _repo;
  final AshaWorker? _worker;
  final Ref _ref;

  ReportWizardNotifier(this._repo, this._worker, this._ref)
      : super(const ReportWizardState());

  void nextStep() {
    if (state.currentStep < 4) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void prevStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void goToStep(int step) {
    state = state.copyWith(currentStep: step);
  }

  void updateSyndromic(SyndromicData data) =>
      state = state.copyWith(syndromic: data);
  void updateMaternal(MaternalHealthData data) =>
      state = state.copyWith(maternal: data);
  void updateChild(ChildHealthData data) =>
      state = state.copyWith(child: data);
  void updateEnvironmental(EnvironmentalData data) =>
      state = state.copyWith(environmental: data);
  void updateLocation(GeoLocation loc) =>
      state = state.copyWith(location: loc);
  void updateWard(String code) => state = state.copyWith(wardCode: code);
  void addPhoto(String path) {
    state = state.copyWith(photoPaths: [...state.photoPaths, path]);
  }
  void removePhoto(int index) {
    final list = [...state.photoPaths];
    list.removeAt(index);
    state = state.copyWith(photoPaths: list);
  }

  Future<bool> submit() async {
    final _logger = Logger();
    _logger.i('Submitting report via wizard');

    if (_worker == null) return false;
    state = state.copyWith(isSubmitting: true, error: null);
    try {
      await _repo.saveReport(
        workerId: _worker!.id,
        workerName: _worker!.fullName,
        wardCode: state.wardCode ?? _worker!.wardCode,
        syndromic: state.syndromic,
        maternal: state.maternal,
        child: state.child,
        environmental: state.environmental,
        location: state.location,
        photoPaths: state.photoPaths,
      );
      
      _logger.i('Report saved successfully');

      _ref.invalidate(todaysReportsProvider);
      _ref.invalidate(allReportsProvider);
      _ref.invalidate(pendingCountProvider);
      
      state = state.copyWith(isSubmitting: false, isSubmitted: true);
      return true;
    } catch (e) {
      _logger.e('Report submission failed', error: e);
      state = state.copyWith(
          isSubmitting: false, error: 'Failed to save report: $e');
      return false;
    }
  }

  Future<bool> saveDraft() async {
    if (_worker == null) return false;
    state = state.copyWith(isSubmitting: true, error: null);
    try {
      await _repo.saveReport(
        workerId: _worker!.id,
        workerName: _worker!.fullName,
        wardCode: state.wardCode ?? _worker!.wardCode,
        syndromic: state.syndromic,
        maternal: state.maternal,
        child: state.child,
        environmental: state.environmental,
        location: state.location,
        photoPaths: state.photoPaths,
        isDraft: true,
      );
      state = state.copyWith(isSubmitting: false, isSubmitted: true);
      return true;
    } catch (e) {
      state =
          state.copyWith(isSubmitting: false, error: 'Failed to save draft: $e');
      return false;
    }
  }

  void reset() => state = const ReportWizardState();
}

final reportWizardProvider =
    StateNotifierProvider<ReportWizardNotifier, ReportWizardState>((ref) {
  final worker = ref.watch(currentWorkerProvider);
  return ReportWizardNotifier(ref.read(reportRepositoryProvider), worker, ref);
});

// ─── Connectivity Provider ─────────────────────────────────────────────────────

final isOnlineProvider = StreamProvider<bool>((ref) async* {
  final api = ref.watch(apiServiceProvider);
  while (true) {
    try {
      await api.get('/health');
      yield true;
    } catch (e) {
      // If the health endpoint returns an error, treat as offline
      yield false;
    }
    await Future.delayed(const Duration(seconds: 10)); // Check every 10 seconds
  }
});
