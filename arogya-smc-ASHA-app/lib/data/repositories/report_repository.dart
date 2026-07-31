import 'dart:convert';
import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';

import '../../core/constants/app_constants.dart';
import '../../main.dart' show appDatabase;
import '../database/app_database.dart';
import '../models/models.dart';
import '../services/api_service.dart';

import 'package:logger/logger.dart';

class ReportRepository {
  final ApiService _api;
  final _uuid = const Uuid();
  final Logger _logger = Logger();

  ReportRepository(this._api);

  Future<void> syncReportToBackend(ReportsTableData localReport) async {
    _logger.i('Syncing report ${localReport.id} to backend');
    try {
      final response = await _api.post('/reports', {
        'worker_id': localReport.workerId,
        'ward_code': localReport.wardCode,
        'report_date': localReport.reportDate.toIso8601String().split('T')[0],
        'fever_count': localReport.feverCount,
        'cough_count': localReport.coughCount,
        'diarrhea_count': localReport.diarrheaCount,
        'jaundice_count': localReport.jaundiceCount,
        'rash_count': localReport.rashCount,
        'disease_type': localReport.diseaseType ?? 'General Fever',
        'maternal_risk_flags': jsonDecode(localReport.maternalRiskFlags),
        'child_risk_flags': jsonDecode(localReport.childRiskFlags),
        'environmental_flags': jsonDecode(localReport.environmentalFlags),
        'location_lat': localReport.locationLat,
        'location_lng': localReport.locationLng,
        'photo_paths': jsonDecode(localReport.photoPaths),
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Mark as synced locally
        await appDatabase.updateSyncStatus(localReport.id, 1);
        _logger.i('Sync response: ${response.statusCode} - ${response.data}');
      } else {
        throw Exception('Sync failed with status ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Sync failed for report ${localReport.id}', error: e);
      // Mark as failed
      await appDatabase.updateSyncStatus(localReport.id, 2);
      rethrow;
    }
  }

  Future<String> saveReport({
    required String workerId,
    required String workerName,
    required String wardCode,
    required SyndromicData syndromic,
    required MaternalHealthData maternal,
    required ChildHealthData child,
    required EnvironmentalData environmental,
    GeoLocation? location,
    List<String> photoPaths = const [],
    bool isDraft = false,
  }) async {
    final reportId = _uuid.v4();
    final now = DateTime.now();
    _logger.i('Saving report: workerId=$workerId, wardCode=$wardCode');
    try {
      await appDatabase.insertReport(ReportsTableCompanion(
        id: Value(reportId),
        workerId: Value(workerId),
        workerName: Value(workerName),
        wardCode: Value(wardCode),
        reportDate: Value(now),
        submissionTime: Value(now),
        feverCount: Value(syndromic.feverCount),
        coughCount: Value(syndromic.coughCount),
        diarrheaCount: Value(syndromic.diarrheaCount),
        jaundiceCount: Value(syndromic.jaundiceCount),
        rashCount: Value(syndromic.rashCount),
        diseaseType: Value(syndromic.diseaseType),
        maternalRiskFlags: Value(maternal.toJsonString()),
        childRiskFlags: Value(child.toJsonString()),
        environmentalFlags: Value(environmental.toJsonString()),
        locationLat: Value(location?.latitude),
        locationLng: Value(location?.longitude),
        photoPaths: Value(jsonEncode(photoPaths)),
        syncStatus: const Value(0),
      ));
      _logger.i('Report inserted locally with id $reportId');
    } catch (e) {
      _logger.e('Failed to insert report locally', error: e);
      rethrow;
    }
    
    // Try to sync immediately (don't await, run in background)
    syncReportToBackend(await appDatabase.getReportById(reportId)).catchError((e) {
      _logger.e('Background sync failed: $e', error: e);
    });
    
    return reportId;
  }

  AshaReport _mapRowToReport(ReportsTableData row) {
    return AshaReport(
      reportId: row.id,
      ashaWorkerId: row.workerId,
      workerName: row.workerName,
      wardCode: row.wardCode,
      reportDate: row.reportDate,
      submissionTime: row.submissionTime,
      syncStatus: row.syncStatus == 1 ? SyncStatus.synced : SyncStatus.pending,
      syndromic: SyndromicData(
        feverCount: row.feverCount,
        coughCount: row.coughCount,
        diarrheaCount: row.diarrheaCount,
        jaundiceCount: row.jaundiceCount,
        rashCount: row.rashCount,
        diseaseType: row.diseaseType,
      ),
      maternal: MaternalHealthData.fromJsonString(row.maternalRiskFlags),
      child: ChildHealthData.fromJsonString(row.childRiskFlags),
      environmental: EnvironmentalData.fromJsonString(row.environmentalFlags),
      location: row.locationLat != null && row.locationLng != null
          ? GeoLocation(latitude: row.locationLat!, longitude: row.locationLng!)
          : null,
      photoPaths: List<String>.from(jsonDecode(row.photoPaths)),
    );
  }

  Future<List<AshaReport>> getPendingReports() async {
    final rows = await appDatabase.getPendingReports();
    return rows.map(_mapRowToReport).toList();
  }

  Future<void> updateSyncStatus(String id, int status) => appDatabase.updateSyncStatus(id, status);
  
  Future<List<AshaReport>> getReportsByWorker(String workerId) async {
    final rows = await appDatabase.getReportsByWorker(workerId);
    return rows.map(_mapRowToReport).toList();
  }

  Future<List<AshaReport>> getTodaysReports(String workerId) async {
    final rows = await appDatabase.getReportsByWorker(workerId);
    final now = DateTime.now();
    return rows.map(_mapRowToReport).where((r) => 
      r.reportDate.year == now.year && 
      r.reportDate.month == now.month && 
      r.reportDate.day == now.day
    ).toList();
  }

  Future<int> getPendingCount() async {
    final rows = await appDatabase.getPendingReports();
    return rows.length;
  }
}
