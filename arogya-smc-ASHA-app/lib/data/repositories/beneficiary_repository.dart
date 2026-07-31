import 'dart:convert';
import 'package:drift/drift.dart' show Value;
import '../../core/constants/app_constants.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';
import '../../main.dart' show appDatabase;
import '../database/app_database.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class BeneficiaryRepository {
  final ApiService _api;
  final _uuid = const Uuid();
  final Logger _logger = Logger();
  BeneficiaryRepository(this._api);

  // ---------- FAMILY ----------
  Future<void> syncFamilyToBackend(FamiliesTableData localData) async {
    try {
      final response = await _api.post('/beneficiaries', {
        'id': localData.id,
        'family_name': localData.familyName,
        'head_name': localData.headName,
        'ward_code': localData.wardCode,
        'address': localData.address,
        'contact_number': localData.contactNumber,
        'total_members': localData.totalMembers,
        'pregnant_women_count': localData.pregnantWomenCount,
        'children_count': localData.childrenCount,
        'high_risk_flag': localData.highRiskFlag,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        await appDatabase.updateFamilySyncStatus(localData.id, 1);
      }
    } catch (e) {
      await appDatabase.updateFamilySyncStatus(localData.id, 2);
    }
  }

  Future<String> saveFamily(FamilyModel family) async {
    _logger.i('Saving family: ${family.familyName}');
    final familyId = _uuid.v4();
    final now = DateTime.now();
    await appDatabase.insertFamily(FamiliesTableCompanion(
      id: Value(familyId),
      familyName: Value(family.familyName),
      headName: Value(family.headOfFamily),
      wardCode: Value(family.wardCode),
      address: Value(family.address),
      contactNumber: Value(family.phoneNumber),
      totalMembers: Value(family.memberCount),
      pregnantWomenCount: const Value(0),
      childrenCount: const Value(0),
      highRiskFlag: const Value(false),
      createdAt: Value(now),
      lastVisit: Value(now),
      syncStatus: const Value(0),
    ));

    syncFamilyToBackend(await appDatabase.getFamilyById(familyId)).catchError((_) {});
    return familyId;
  }

  Future<void> updateFamily(FamilyModel family) async {
    final id = family.familyId;
    final fData = await appDatabase.getFamilyById(id);
    await appDatabase.updateFamily(FamiliesTableCompanion(
      id: Value(id),
      familyName: Value(family.familyName),
      headName: Value(family.headOfFamily),
      wardCode: Value(family.wardCode),
      address: Value(family.address),
      contactNumber: Value(family.phoneNumber),
      totalMembers: Value(family.memberCount),
      pregnantWomenCount: const Value(0),
      childrenCount: const Value(0),
      highRiskFlag: const Value(false),
      createdAt: Value(fData.createdAt),
      lastVisit: Value(DateTime.now()),
      syncStatus: const Value(0),
    ));
    syncFamilyToBackend(await appDatabase.getFamilyById(id)).catchError((_) {});
  }

  // ---------- CHILD ----------
  Future<void> syncChildToBackend(ChildrenTableData child) async {
    try {
      final res = await _api.post('/beneficiaries/children', {
        'id': child.id,
        'family_id': child.familyId,
        'name': child.name,
        'date_of_birth': child.dateOfBirth.toIso8601String(),
        'gender': child.gender,
        'blood_group': child.bloodGroup,
        'nutrition_status': child.nutritionStatus,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        await appDatabase.updateChildSyncStatus(child.id, 1);
      }
    } catch (e) {
      await appDatabase.updateChildSyncStatus(child.id, 2);
    }
  }

  Future<String> saveChild(ChildProfileModel child) async {
    _logger.i('Saving child: ${child.name}, familyId=${child.familyId}');
    final childId = _uuid.v4();
    await appDatabase.insertChild(ChildrenTableCompanion(
      id: Value(childId),
      familyId: Value(child.familyId),
      name: Value(child.name),
      dateOfBirth: Value(child.dateOfBirth),
      gender: Value(child.gender),
      bloodGroup: Value(child.bloodGroup),
      nutritionStatus: const Value('normal'),
      createdAt: Value(DateTime.now()),
      syncStatus: const Value(0),
    ));
    syncChildToBackend(await appDatabase.getChildById(childId)).catchError((_){});
    return childId;
  }

  // ---------- VISIT ----------
  Future<void> syncVisitToBackend(VisitsTableData visit) async {
    try {
      final res = await _api.post('/visits', {
        'id': visit.id,
        'family_id': visit.familyId,
        'visit_date': visit.visitDate.toIso8601String(),
        'health_status': visit.healthStatus,
        'fever': visit.fever,
        'cough': visit.cough,
        'diarrhea': visit.diarrhea,
        'notes': visit.notes,
        'follow_up_required': visit.followUpRequired,
        'location_lat': visit.locationLat,
        'location_lng': visit.locationLng,
        'photo_path': visit.photoPath,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        await appDatabase.updateVisitSyncStatus(visit.id, 1);
      }
    } catch (_) {
      await appDatabase.updateVisitSyncStatus(visit.id, 2);
    }
  }

  Future<String> saveVisit(VisitRecordModel visitModel) async {
    final vId = _uuid.v4();
    await appDatabase.insertVisit(VisitsTableCompanion(
      id: Value(vId),
      familyId: Value(visitModel.familyId),
      visitDate: Value(visitModel.visitDate),
      healthStatus: const Value('Good'),
      fever: const Value(false),
      cough: const Value(false),
      diarrhea: const Value(false),
      notes: Value(visitModel.notes),
      followUpRequired: const Value(false),
      locationLat: Value(visitModel.latitude),
      locationLng: Value(visitModel.longitude),
      photoPath: Value(visitModel.photoPath),
      syncStatus: const Value(0),
    ));
    syncVisitToBackend(await appDatabase.getVisitById(vId)).catchError((_){});
    return vId;
  }

  // ---------- VACCINATION ----------
  Future<void> syncVaccinationToBackend(VaccinationsTableData v) async {
    try {
      final res = await _api.post('/vaccinations', {
        'id': v.id,
        'child_id': v.childId,
        'vaccine_name': v.vaccineName,
        'dose_number': v.doseNumber,
        'date_given': v.dateGiven.toIso8601String(),
        'next_due_date': v.nextDueDate?.toIso8601String(),
        'remarks': v.remarks,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        await appDatabase.updateVaccinationSyncStatus(v.id, 1);
      }
    } catch (_) {
      await appDatabase.updateVaccinationSyncStatus(v.id, 2);
    }
  }

  Future<void> saveVaccination(VaccinationRecordModel vacc) async {
    final vId = await appDatabase.insertVaccination(VaccinationsTableCompanion(
      childId: Value(vacc.childId),
      vaccineName: Value(vacc.vaccineName),
      doseNumber: Value(vacc.doseNumber),
      dateGiven: Value(vacc.dateAdministered),
      nextDueDate: const Value(null),
      remarks: Value(vacc.remarks),
      syncStatus: const Value(0),
    ));
    syncVaccinationToBackend(await appDatabase.getVaccinationById(vId)).catchError((_) {});
  }

  // ---------- GROWTH MEASUREMENT ----------
  Future<void> syncGrowthMeasurementToBackend(GrowthMeasurementsTableData m) async {
    try {
      final res = await _api.post('/growth_measurements', {
        'id': m.id,
        'child_id': m.childId,
        'measured_at': m.measuredAt.toIso8601String(),
        'weight_kg': m.weightKg,
        'height_cm': m.heightCm,
        'age_months': m.ageMonths,
        'nutrition_status': m.nutritionStatus,
        'notes': m.notes,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        await appDatabase.updateGrowthMeasurementSyncStatus(m.id, 1);
      }
    } catch (_) {
      await appDatabase.updateGrowthMeasurementSyncStatus(m.id, 2);
    }
  }

  Future<void> saveGrowthMeasurement(GrowthMeasurementModel m) async {
    final mId = await appDatabase.insertGrowthMeasurement(GrowthMeasurementsTableCompanion(
      childId: Value(m.childId),
      measuredAt: Value(m.measuredAt),
      weightKg: Value(m.weightKg),
      heightCm: Value(m.heightCm),
      ageMonths: Value(m.ageMonths),
      nutritionStatus: Value(m.nutritionStatus),
      notes: Value(m.notes),
      syncStatus: const Value(0),
    ));
    syncGrowthMeasurementToBackend(await appDatabase.getGrowthMeasurementById(mId)).catchError((_){});
  }

  Future<List<Map<String, String>>> fetchWards() async {
    try {
      final response = await _api.get('/wards');
      if (response.statusCode == 200 && response.data['wards'] != null) {
        return List<Map<String, String>>.from((response.data['wards'] as List).map((w) => {
          'code': w['code'].toString(),
          'name': w['name'].toString(),
        }));
      }
      return AppConstants.wards;
    } catch (_) {
      return AppConstants.wards;
    }
  }

  Future<List<Map<String, dynamic>>> fetchFacilities() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      final response = await _api.get('/facilities/nearby', queryParameters: {
        'lat': position.latitude.toString(),
        'lng': position.longitude.toString(),
        'radius': '5000',
      });
      if (response.statusCode == 200 && response.data['facilities'] != null) {
        return List<Map<String, dynamic>>.from(response.data['facilities']);
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<List<FamilyModel>> getFamiliesByWard(String wardCode) async {
    _logger.i('getFamiliesByWard called with wardCode: "$wardCode"');
    
    // Dump ALL families to see what actually exists
    final allFamilies = await appDatabase.select(appDatabase.familiesTable).get();
    _logger.i('Total families in SQLite database: ${allFamilies.length}');
    for (var i = 0; i < allFamilies.length; i++) {
       _logger.d('Family $i: name=${allFamilies[i].familyName}, wardCode="${allFamilies[i].wardCode}"');
    }

    final rows = await (appDatabase.select(appDatabase.familiesTable)
        ..where((f) => f.wardCode.equals(wardCode))).get();
    
    _logger.i('Families actually matching wardCode "$wardCode": ${rows.length}');

    final families = <FamilyModel>[];
    for (final row in rows) {
      final childrenRows = await (appDatabase.select(appDatabase.childrenTable)
          ..where((c) => c.familyId.equals(row.id))).get();
      
      final members = childrenRows.map((c) => BeneficiaryModel(
        beneficiaryId: c.id,
        familyId: c.familyId,
        name: c.name,
        age: DateTime.now().year - c.dateOfBirth.year,
        gender: c.gender,
        address: row.address,
        wardCode: row.wardCode,
        createdAt: c.createdAt,
      )).toList();

      families.add(FamilyModel(
        familyId: row.id,
        familyName: row.familyName,
        wardCode: row.wardCode,
        address: row.address,
        headOfFamily: row.headName,
        phoneNumber: row.contactNumber ?? '',
        memberCount: row.totalMembers,
        registeredAt: row.createdAt,
        lastVisit: row.lastVisit,
        members: members,
      ));
    }
    return families;
  }

  Future<FamilyModel?> getFamilyById(String familyId) async {
    try {
      final row = await (appDatabase.select(appDatabase.familiesTable)
          ..where((f) => f.id.equals(familyId))).getSingle();
      
      final childrenRows = await (appDatabase.select(appDatabase.childrenTable)
          ..where((c) => c.familyId.equals(familyId))).get();
      
      final members = childrenRows.map((c) => BeneficiaryModel(
        beneficiaryId: c.id,
        familyId: c.familyId,
        name: c.name,
        age: DateTime.now().year - c.dateOfBirth.year,
        gender: c.gender,
        address: row.address,
        wardCode: row.wardCode,
        createdAt: c.createdAt,
      )).toList();

      return FamilyModel(
        familyId: row.id,
        familyName: row.familyName,
        wardCode: row.wardCode,
        address: row.address,
        headOfFamily: row.headName,
        phoneNumber: row.contactNumber ?? '',
        memberCount: row.totalMembers,
        registeredAt: row.createdAt,
        lastVisit: row.lastVisit,
        members: members,
      );
    } catch (_) {
      return null;
    }
  }

  Future<List<BeneficiaryModel>> getBeneficiariesByFamily(String familyId) async {
    final row = await getFamilyById(familyId);
    return row?.members ?? [];
  }

  Future<BeneficiaryModel?> getBeneficiaryById(String id) async {
    try {
      final c = await (appDatabase.select(appDatabase.childrenTable)
          ..where((tbl) => tbl.id.equals(id))).getSingle();
      final family = await getFamilyById(c.familyId);
      
      return BeneficiaryModel(
        beneficiaryId: c.id,
        familyId: c.familyId,
        name: c.name,
        age: DateTime.now().year - c.dateOfBirth.year,
        gender: c.gender,
        address: family?.address ?? '',
        wardCode: family?.wardCode ?? '',
        createdAt: c.createdAt,
      );
    } catch (_) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getVisitsByBeneficiary(String beneficiaryId) async {
    final rows = await (appDatabase.select(appDatabase.visitsTable)
        ..where((v) => v.familyId.equals(beneficiaryId))).get(); 
    return rows.map((r) => {
      'id': r.id,
      'date': r.visitDate.toIso8601String(),
      'status': r.healthStatus,
      'notes': r.notes ?? '',
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getVaccinationsByBeneficiary(String beneficiaryId) async {
    final rows = await (appDatabase.select(appDatabase.vaccinationsTable)
        ..where((v) => v.childId.equals(beneficiaryId))).get();
    return rows.map((r) => {
      'id': r.id.toString(),
      'vaccine_name': r.vaccineName,
      'dose_number': r.doseNumber,
      'date_given': r.dateGiven.toIso8601String(),
    }).toList();
  }

  Future<List<GrowthMeasurementModel>> getMeasurementsByChild(String childId) async {
    final rows = await (appDatabase.select(appDatabase.growthMeasurementsTable)
        ..where((m) => m.childId.equals(childId))).get();
    return rows.map((r) => GrowthMeasurementModel(
      id: r.id,
      childId: r.childId,
      measuredAt: r.measuredAt,
      weightKg: r.weightKg,
      heightCm: r.heightCm,
      ageMonths: r.ageMonths,
      nutritionStatus: r.nutritionStatus,
      notes: r.notes,
    )).toList();
  }
}
