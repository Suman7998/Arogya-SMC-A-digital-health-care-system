// lib/data/services/local_storage_service.dart
//
// Hive-based local cache for hospital data.
// Cache is valid for AppConstants.cacheDurationMinutes (30 min).

import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/app_constants.dart';

class LocalStorageService {
  static const String _cacheTimeKey = 'hospitals_cache_time';
  static const String _hospitalsKey = 'hospitals_data';

  Box get _box => Hive.box(AppConstants.hospitalsBox);

  bool get isCacheValid {
    final stored = _box.get(_cacheTimeKey) as int?;
    if (stored == null) return false;
    final cacheTime = DateTime.fromMillisecondsSinceEpoch(stored);
    final diff = DateTime.now().difference(cacheTime).inMinutes;
    return diff < AppConstants.cacheDurationMinutes;
  }

  Future<void> saveHospitals(List<Map<String, dynamic>> hospitals) async {
    await _box.put(_hospitalsKey, jsonEncode(hospitals));
    await _box.put(_cacheTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  List<Map<String, dynamic>>? loadHospitals() {
    final raw = _box.get(_hospitalsKey) as String?;
    if (raw == null) return null;
    final decoded = jsonDecode(raw) as List;
    return decoded.cast<Map<String, dynamic>>();
  }

  Future<void> clearHospitalsCache() async {
    await _box.delete(_hospitalsKey);
    await _box.delete(_cacheTimeKey);
  }

  // Alerts cache
  Future<void> saveAlerts(List<Map<String, dynamic>> alerts) async {
    final box = Hive.box(AppConstants.alertsBox);
    await box.put('alerts', jsonEncode(alerts));
    await box.put('alerts_cache_time', DateTime.now().millisecondsSinceEpoch);
  }

  List<Map<String, dynamic>>? loadAlerts() {
    final raw = Hive.box(AppConstants.alertsBox).get('alerts') as String?;
    if (raw == null) return null;
    final decoded = jsonDecode(raw) as List;
    return decoded.cast<Map<String, dynamic>>();
  }

  bool get alertsCacheValid {
    final stored = Hive.box(AppConstants.alertsBox).get('alerts_cache_time') as int?;
    if (stored == null) return false;
    final cacheTime = DateTime.fromMillisecondsSinceEpoch(stored);
    return DateTime.now().difference(cacheTime).inMinutes < AppConstants.cacheDurationMinutes;
  }

  // Advisories cache
  Future<void> saveAdvisories(List<Map<String, dynamic>> advisories) async {
    final box = Hive.box(AppConstants.advisoriesBox);
    await box.put('advisories', jsonEncode(advisories));
    await box.put('advisories_cache_time', DateTime.now().millisecondsSinceEpoch);
  }

  List<Map<String, dynamic>>? loadAdvisories() {
    final raw = Hive.box(AppConstants.advisoriesBox).get('advisories') as String?;
    if (raw == null) return null;
    final decoded = jsonDecode(raw) as List;
    return decoded.cast<Map<String, dynamic>>();
  }

  bool get advisoriesCacheValid {
    final stored = Hive.box(AppConstants.advisoriesBox).get('advisories_cache_time') as int?;
    if (stored == null) return false;
    final cacheTime = DateTime.fromMillisecondsSinceEpoch(stored);
    return DateTime.now().difference(cacheTime).inMinutes < AppConstants.cacheDurationMinutes;
  }

  // Settings helpers
  Future<void> saveNotificationEnabled(bool enabled) async {
    final settingsBox = Hive.box(AppConstants.settingsBox);
    await settingsBox.put('notifications_enabled', enabled);
  }

  bool getNotificationEnabled() {
    final settingsBox = Hive.box(AppConstants.settingsBox);
    return settingsBox.get('notifications_enabled', defaultValue: true) as bool;
  }
}
