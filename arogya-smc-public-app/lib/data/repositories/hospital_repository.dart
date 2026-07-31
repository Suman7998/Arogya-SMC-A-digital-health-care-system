// lib/data/repositories/hospital_repository.dart
//
// Repository pattern: checks Hive cache → falls back to ApiService → saves cache.

import '../models/hospital_model.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

class HospitalRepository {
  final ApiService _apiService;
  final LocalStorageService _storage;

  HospitalRepository({
    ApiService? apiService,
    LocalStorageService? storage,
  })  : _apiService = apiService ?? ApiService(),
        _storage = storage ?? LocalStorageService();

  Future<List<HospitalModel>> getHospitals({bool forceRefresh = false}) async {
    // Try cache first
    if (!forceRefresh && _storage.isCacheValid) {
      final cached = _storage.loadHospitals();
      if (cached != null) {
        return cached.map((json) => HospitalModel.fromJson(json)).toList();
      }
    }
    // Fetch from backend /facilities
    final hospitals = await _apiService.fetchFacilities();
    // Persist to Hive
    await _storage.saveHospitals(
      hospitals.map((h) => h.toJson()).toList(),
    );
    return hospitals;
  }

  Future<HospitalModel?> getHospitalById(String id) async {
    final all = await getHospitals();
    try {
      return all.firstWhere((h) => h.id == id);
    } catch (_) {
      return null;
    }
  }
}
