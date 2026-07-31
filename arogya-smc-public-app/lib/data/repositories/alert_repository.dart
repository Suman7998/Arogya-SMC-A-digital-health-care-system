// lib/data/repositories/alert_repository.dart

import '../models/alert_model.dart';
import '../models/advisory_model.dart';
import '../services/api_service.dart';

import '../services/local_storage_service.dart';

class AlertRepository {
  final ApiService _apiService;
  final LocalStorageService _storage;

  AlertRepository({ApiService? apiService, LocalStorageService? storage})
      : _apiService = apiService ?? ApiService(),
        _storage = storage ?? LocalStorageService();

  Future<List<AlertModel>> getAlerts({bool forceRefresh = false}) async {
    if (!forceRefresh && _storage.alertsCacheValid) {
      final cached = _storage.loadAlerts();
      if (cached != null) {
        return cached.map((json) => AlertModel.fromJson(json)).toList();
      }
    }
    final alerts = await _apiService.fetchAlerts();
    await _storage.saveAlerts(alerts.map((a) => a.toJson()).toList());
    return alerts;
  }

  Future<List<AdvisoryModel>> getAdvisories({bool forceRefresh = false}) async {
    if (!forceRefresh && _storage.advisoriesCacheValid) {
      final cached = _storage.loadAdvisories();
      if (cached != null) {
        return cached.map((json) => AdvisoryModel.fromJson(json)).toList();
      }
    }
    final advisories = await _apiService.fetchAdvisories();
    await _storage.saveAdvisories(advisories.map((a) => a.toJson()).toList());
    return advisories;
  }
}
