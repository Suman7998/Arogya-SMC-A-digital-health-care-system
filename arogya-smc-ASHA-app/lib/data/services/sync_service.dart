import 'package:connectivity_plus/connectivity_plus.dart';
import '../../main.dart' show appDatabase;
import '../database/app_database.dart';
import '../repositories/report_repository.dart';
import '../repositories/beneficiary_repository.dart';

class SyncService {
  final ReportRepository _reportRepo;
  final BeneficiaryRepository _beneficiaryRepo;
  
  SyncService(this._reportRepo, this._beneficiaryRepo);
  
  void startListening() {
    Connectivity().onConnectivityChanged.listen((dynamic result) {
      if (result is List<ConnectivityResult>) {
        if (result.isNotEmpty && result.first != ConnectivityResult.none) {
          syncAll();
        }
      } else if (result is ConnectivityResult) {
        if (result != ConnectivityResult.none) {
          syncAll();
        }
      }
    });
  }
  
  Future<void> syncAll() async {
    await syncReports();
    await syncFamilies();
    await syncChildren();
    await syncVisits();
    await syncVaccinations();
    await syncGrowthMeasurements();
  }
  
  Future<void> syncReports() async {
    final pending = await appDatabase.getPendingReports();
    for (final report in pending) {
      try {
        await _reportRepo.syncReportToBackend(report);
      } catch (e) {
        // log error
      }
    }
  }

  Future<void> syncFamilies() async {
    final pending = await appDatabase.select(appDatabase.familiesTable).get();
    for (final family in pending.where((f) => f.syncStatus == 0)) {
      try {
        await _beneficiaryRepo.syncFamilyToBackend(family);
      } catch (e) {}
    }
  }

  Future<void> syncChildren() async {
    final pending = await appDatabase.select(appDatabase.childrenTable).get();
    for (final child in pending.where((c) => c.syncStatus == 0)) {
      try {
        await _beneficiaryRepo.syncChildToBackend(child);
      } catch (e) {}
    }
  }

  Future<void> syncVisits() async {
    final pending = await appDatabase.select(appDatabase.visitsTable).get();
    for (final visit in pending.where((v) => v.syncStatus == 0)) {
      try {
        await _beneficiaryRepo.syncVisitToBackend(visit);
      } catch (e) {}
    }
  }

  Future<void> syncVaccinations() async {
    final pending = await appDatabase.select(appDatabase.vaccinationsTable).get();
    for (final vacc in pending.where((v) => v.syncStatus == 0)) {
      try {
        await _beneficiaryRepo.syncVaccinationToBackend(vacc);
      } catch (e) {}
    }
  }

  Future<void> syncGrowthMeasurements() async {
    final pending = await appDatabase.select(appDatabase.growthMeasurementsTable).get();
    for (final m in pending.where((m) => m.syncStatus == 0)) {
      try {
        await _beneficiaryRepo.syncGrowthMeasurementToBackend(m);
      } catch (e) {}
    }
  }
}
