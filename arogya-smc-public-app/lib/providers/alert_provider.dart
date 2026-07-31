// lib/providers/alert_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/alert_model.dart';
import '../data/models/advisory_model.dart';
import '../data/repositories/alert_repository.dart';

import '../data/services/local_storage_service.dart';

final alertRepositoryProvider = Provider<AlertRepository>((ref) {
  return AlertRepository(storage: LocalStorageService());
});

// All alerts async provider
final alertListProvider =
    AsyncNotifierProvider<AlertNotifier, List<AlertModel>>(
  AlertNotifier.new,
);

class AlertNotifier extends AsyncNotifier<List<AlertModel>> {
  @override
  Future<List<AlertModel>> build() async {
    final repo = ref.read(alertRepositoryProvider);
    return repo.getAlerts();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final repo = ref.read(alertRepositoryProvider);
    state = await AsyncValue.guard(() => repo.getAlerts(forceRefresh: true));
  }
}

// Selected filter type (null = All)
final alertFilterProvider = StateProvider<AlertType?>((ref) => null);

// Filtered alerts
final filteredAlertsProvider = Provider<AsyncValue<List<AlertModel>>>((ref) {
  final filter = ref.watch(alertFilterProvider);
  final alertsAsync = ref.watch(alertListProvider);
  return alertsAsync.whenData(
    (alerts) => filter == null
        ? alerts
        : alerts.where((a) => a.type == filter).toList(),
  );
});

// Advisories provider for home screen carousel
final advisoriesProvider =
    FutureProvider<List<AdvisoryModel>>((ref) async {
  final repo = ref.read(alertRepositoryProvider);
  return repo.getAdvisories();
});
