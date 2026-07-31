// lib/providers/hospital_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/hospital_model.dart';
import '../data/repositories/hospital_repository.dart';

final hospitalRepositoryProvider = Provider<HospitalRepository>((ref) {
  return HospitalRepository();
});

final hospitalListProvider =
    AsyncNotifierProvider<HospitalNotifier, List<HospitalModel>>(
  HospitalNotifier.new,
);

class HospitalNotifier extends AsyncNotifier<List<HospitalModel>> {
  @override
  Future<List<HospitalModel>> build() async {
    final repo = ref.read(hospitalRepositoryProvider);
    return repo.getHospitals();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final repo = ref.read(hospitalRepositoryProvider);
    state = await AsyncValue.guard(
      () => repo.getHospitals(forceRefresh: true),
    );
  }
}

// Computed provider for search filtering
final hospitalSearchQueryProvider = StateProvider<String>((ref) => '');

final filteredHospitalsProvider = Provider<AsyncValue<List<HospitalModel>>>(
  (ref) {
    final query = ref.watch(hospitalSearchQueryProvider).toLowerCase();
    final hospitalsAsync = ref.watch(hospitalListProvider);
    return hospitalsAsync.whenData(
      (hospitals) => hospitals.where((h) {
        if (query.isEmpty) return true;
        return h.name.toLowerCase().contains(query) ||
            h.ward.toLowerCase().contains(query) ||
            h.type.toLowerCase().contains(query);
      }).toList(),
    );
  },
);
