import 'dart:convert';
import 'package:flutter/material.dart';

class SyndromicData {
  final int feverCount;
  final int coughCount;
  final int diarrheaCount;
  final int jaundiceCount;
  final int rashCount;
  final String? diseaseType;
  final Map<String, int> otherSymptoms;

  const SyndromicData({
    this.feverCount = 0,
    this.coughCount = 0,
    this.diarrheaCount = 0,
    this.jaundiceCount = 0,
    this.rashCount = 0,
    this.diseaseType,
    this.otherSymptoms = const {},
  });

  SyndromicData copyWith({
    int? feverCount,
    int? coughCount,
    int? diarrheaCount,
    int? jaundiceCount,
    int? rashCount,
    String? diseaseType,
    Map<String, int>? otherSymptoms,
  }) {
    return SyndromicData(
      feverCount: feverCount ?? this.feverCount,
      coughCount: coughCount ?? this.coughCount,
      diarrheaCount: diarrheaCount ?? this.diarrheaCount,
      jaundiceCount: jaundiceCount ?? this.jaundiceCount,
      rashCount: rashCount ?? this.rashCount,
      diseaseType: diseaseType ?? this.diseaseType,
      otherSymptoms: otherSymptoms ?? this.otherSymptoms,
    );
  }

  Map<String, dynamic> toJson() => {
        'fever_count': feverCount,
        'cough_count': coughCount,
        'diarrhea_count': diarrheaCount,
        'jaundice_count': jaundiceCount,
        'rash_count': rashCount,
        'disease_type': diseaseType,
        'other_symptoms': otherSymptoms,
      };

  factory SyndromicData.fromJson(Map<String, dynamic> json) => SyndromicData(
        feverCount: json['fever_count'] ?? 0,
        coughCount: json['cough_count'] ?? 0,
        diarrheaCount: json['diarrhea_count'] ?? 0,
        jaundiceCount: json['jaundice_count'] ?? 0,
        rashCount: json['rash_count'] ?? 0,
        diseaseType: json['disease_type'],
        otherSymptoms: Map<String, int>.from(json['other_symptoms'] ?? {}),
      );

  String toJsonString() => jsonEncode(toJson());
  factory SyndromicData.fromJsonString(String s) =>
      SyndromicData.fromJson(jsonDecode(s));

  int get totalCases =>
      feverCount +
      coughCount +
      diarrheaCount +
      jaundiceCount +
      rashCount +
      otherSymptoms.values.fold(0, (sum, count) => sum + count);
}

class MaternalHealthData {
  final bool highRiskPregnancy;
  final bool postnatalComplications;
  final bool noAncVisit;

  const MaternalHealthData({
    this.highRiskPregnancy = false,
    this.postnatalComplications = false,
    this.noAncVisit = false,
  });

  MaternalHealthData copyWith({
    bool? highRiskPregnancy,
    bool? postnatalComplications,
    bool? noAncVisit,
  }) {
    return MaternalHealthData(
      highRiskPregnancy: highRiskPregnancy ?? this.highRiskPregnancy,
      postnatalComplications: postnatalComplications ?? this.postnatalComplications,
      noAncVisit: noAncVisit ?? this.noAncVisit,
    );
  }

  Map<String, dynamic> toJson() => {
        'high_risk_pregnancy': highRiskPregnancy,
        'postnatal_complications': postnatalComplications,
        'no_anc_visit': noAncVisit,
      };

  factory MaternalHealthData.fromJson(Map<String, dynamic> json) =>
      MaternalHealthData(
        highRiskPregnancy: json['high_risk_pregnancy'] ?? false,
        postnatalComplications: json['postnatal_complications'] ?? false,
        noAncVisit: json['no_anc_visit'] ?? false,
      );

  String toJsonString() => jsonEncode(toJson());
  factory MaternalHealthData.fromJsonString(String s) =>
      MaternalHealthData.fromJson(jsonDecode(s));
}

class ChildHealthData {
  final bool malnourished;
  final bool immunizationOverdue;
  final bool sickChild;

  const ChildHealthData({
    this.malnourished = false,
    this.immunizationOverdue = false,
    this.sickChild = false,
  });

  ChildHealthData copyWith({
    bool? malnourished,
    bool? immunizationOverdue,
    bool? sickChild,
  }) {
    return ChildHealthData(
      malnourished: malnourished ?? this.malnourished,
      immunizationOverdue: immunizationOverdue ?? this.immunizationOverdue,
      sickChild: sickChild ?? this.sickChild,
    );
  }

  Map<String, dynamic> toJson() => {
        'malnourished': malnourished,
        'immunization_overdue': immunizationOverdue,
        'sick_child': sickChild,
      };

  factory ChildHealthData.fromJson(Map<String, dynamic> json) => ChildHealthData(
        malnourished: json['malnourished'] ?? false,
        immunizationOverdue: json['immunization_overdue'] ?? false,
        sickChild: json['sick_child'] ?? false,
      );

  String toJsonString() => jsonEncode(toJson());
  factory ChildHealthData.fromJsonString(String s) =>
      ChildHealthData.fromJson(jsonDecode(s));
}

class EnvironmentalData {
  final bool stagnantWaterPresent;
  final bool openGarbage;
  final bool noToilet;
  final bool mosquitoBreeding;
  final String? otherRisks;

  const EnvironmentalData({
    this.stagnantWaterPresent = false,
    this.openGarbage = false,
    this.noToilet = false,
    this.mosquitoBreeding = false,
    this.otherRisks,
  });

  EnvironmentalData copyWith({
    bool? stagnantWaterPresent,
    bool? openGarbage,
    bool? noToilet,
    bool? mosquitoBreeding,
    String? otherRisks,
  }) {
    return EnvironmentalData(
      stagnantWaterPresent: stagnantWaterPresent ?? this.stagnantWaterPresent,
      openGarbage: openGarbage ?? this.openGarbage,
      noToilet: noToilet ?? this.noToilet,
      mosquitoBreeding: mosquitoBreeding ?? this.mosquitoBreeding,
      otherRisks: otherRisks ?? this.otherRisks,
    );
  }

  Map<String, dynamic> toJson() => {
        'stagnant_water': stagnantWaterPresent,
        'open_garbage': openGarbage,
        'no_toilet': noToilet,
        'mosquito_breeding': mosquitoBreeding,
        'other_risks': otherRisks,
      };

  factory EnvironmentalData.fromJson(Map<String, dynamic> json) =>
      EnvironmentalData(
        stagnantWaterPresent: json['stagnant_water'] ?? false,
        openGarbage: json['open_garbage'] ?? false,
        noToilet: json['no_toilet'] ?? false,
        mosquitoBreeding: json['mosquito_breeding'] ?? false,
        otherRisks: json['other_risks'],
      );

  String toJsonString() => jsonEncode(toJson());
  factory EnvironmentalData.fromJsonString(String s) =>
      EnvironmentalData.fromJson(jsonDecode(s));

  int get riskCount =>
      (stagnantWaterPresent ? 1 : 0) +
      (openGarbage ? 1 : 0) +
      (noToilet ? 1 : 0) +
      (mosquitoBreeding ? 1 : 0);
}

class GeoLocation {
  final double latitude;
  final double longitude;
  final double accuracy;
  final String? placemark;

  const GeoLocation({
    required this.latitude,
    required this.longitude,
    this.accuracy = 0.0,
    this.placemark,
  });

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'accuracy': accuracy,
        'placemark': placemark,
      };

  factory GeoLocation.fromJson(Map<String, dynamic> json) => GeoLocation(
        latitude: json['latitude'] ?? 0.0,
        longitude: json['longitude'] ?? 0.0,
        accuracy: json['accuracy'] ?? 0.0,
        placemark: json['placemark'],
      );
}

enum SyncStatus { pending, synced, failed }

class AshaReport {
  final String reportId;
  final String ashaWorkerId;
  final String workerName;
  final String wardCode;
  final DateTime reportDate;
  final DateTime submissionTime;
  final SyncStatus syncStatus;
  final SyndromicData syndromic;
  final MaternalHealthData maternal;
  final ChildHealthData child;
  final EnvironmentalData environmental;
  final GeoLocation? location;
  final List<String> photoPaths;

  const AshaReport({
    required this.reportId,
    required this.ashaWorkerId,
    required this.workerName,
    required this.wardCode,
    required this.reportDate,
    required this.submissionTime,
    required this.syncStatus,
    required this.syndromic,
    required this.maternal,
    required this.child,
    required this.environmental,
    this.location,
    this.photoPaths = const [],
  });

  bool get isSynced => syncStatus == SyncStatus.synced;
  bool get isPending => syncStatus == SyncStatus.pending;
  bool get hasFailed => syncStatus == SyncStatus.failed;
}

class AshaWorker {
  final String id;
  final String username;
  final String fullName;
  final String wardCode;
  final String wardName;
  final String phone;
  final String role;
  final bool isActive;

  const AshaWorker({
    required this.id,
    required this.username,
    required this.fullName,
    required this.wardCode,
    required this.wardName,
    required this.phone,
    this.role = 'asha',
    this.isActive = true,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'fullName': fullName,
        'wardCode': wardCode,
        'wardName': wardName,
        'phone': phone,
        'role': role,
        'isActive': isActive,
      };

  factory AshaWorker.fromJson(Map<String, dynamic> json) => AshaWorker(
        id: json['id'] ?? '',
        username: json['username'] ?? '',
        fullName: json['fullName'] ?? '',
        wardCode: json['wardCode'] ?? '',
        wardName: json['wardName'] ?? '',
        phone: json['phone'] ?? '',
        role: json['role'] ?? 'asha',
        isActive: json['isActive'] ?? true,
      );
}

class AlertModel {
  final String id;
  final String type;
  final String severity;
  final String? wardCode;
  final String title;
  final String? titleMarathi;
  final String? titleHindi;
  final String description;
  final String? descriptionMarathi;
  final String? descriptionHindi;
  final DateTime generatedAt;
  final String status;
  final bool isRead;

  const AlertModel({
    required this.id,
    required this.type,
    required this.severity,
    this.wardCode,
    required this.title,
    this.titleMarathi,
    this.titleHindi,
    required this.description,
    this.descriptionMarathi,
    this.descriptionHindi,
    required this.generatedAt,
    this.status = 'active',
    this.isRead = false,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      id: json['id']?.toString() ?? '',
      type: json['type'] ?? 'other',
      severity: json['severity'] ?? 'low',
      wardCode: json['ward_code']?.toString(),
      title: json['title'] ?? 'Health Alert',
      titleMarathi: json['title_marathi'],
      titleHindi: json['title_hindi'],
      description: json['message'] ?? json['description'] ?? '',
      descriptionMarathi: json['message_marathi'] ?? json['description_marathi'],
      descriptionHindi: json['message_hindi'] ?? json['description_hindi'],
      generatedAt: json['broadcast_at'] != null ? DateTime.parse(json['broadcast_at']) : DateTime.now(),
      status: json['status'] ?? 'active',
      isRead: false,
    );
  }

  Color get severityColor {
    switch (severity) {
      case 'critical':
        return const Color(0xFFF44336);
      case 'high':
        return const Color(0xFFFF5722);
      case 'medium':
        return const Color(0xFFFFC107);
      case 'low':
        return const Color(0xFF4CAF50);
      default:
        return const Color(0xFF9E9E9E);
    }
  }
}

// ─── Beneficiary Models ────────────────────────────────────────────────────

class FamilyModel {
  final String familyId;
  final String familyName;
  final String wardCode;
  final String address;
  final String headOfFamily;
  final String phoneNumber;
  final int memberCount;
  final DateTime registeredAt;
  final DateTime? lastVisit;
  final List<BeneficiaryModel> members;

  const FamilyModel({
    required this.familyId,
    required this.familyName,
    required this.wardCode,
    required this.address,
    required this.headOfFamily,
    required this.phoneNumber,
    required this.memberCount,
    required this.registeredAt,
    this.lastVisit,
    this.members = const [],
  });

  int get childCount =>
      members.where((m) => m.age < 18).length;

  bool get hasPregnantMember =>
      members.any((m) => m.pregnancyStatus == 'pregnant');

  String get lastVisitDisplay {
    if (lastVisit == null) return 'Never visited';
    final diff = DateTime.now().difference(lastVisit!);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays} days ago';
  }

  factory FamilyModel.fromJson(Map<String, dynamic> json) {
    return FamilyModel(
      familyId: (json['id'] ?? json['family_id'] ?? '').toString(),
      familyName: json['family_name'] ?? 'Unknown',
      wardCode: json['ward_code'] ?? '',
      address: json['address'] ?? '',
      headOfFamily: json['head_name'] ?? '',
      phoneNumber: json['contact_number'] ?? '',
      memberCount: json['total_members'] ?? 0,
      registeredAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      lastVisit: json['last_visit'] != null ? DateTime.parse(json['last_visit']) : null,
      members: [],
    );
  }

  Map<String, dynamic> toJson() => {
    'family_name': familyName,
    'head_name': headOfFamily,
    'ward_code': wardCode,
    'address': address,
    'contact_number': phoneNumber,
    'total_members': memberCount,
    'pregnant_women_count': members.where((m) => m.isPregnant).length,
    'children_count': childCount,
  };
}

class BeneficiaryModel {
  final String beneficiaryId;
  final String familyId;
  final String name;
  final int age;
  final String gender;
  final String? aadhaarNumber;
  final String? phoneNumber;
  final String address;
  final String wardCode;
  final String? pregnancyStatus; // pregnant / not / post
  final List<String> healthHistory;
  final Map<String, bool> vaccinationStatus;
  final DateTime? lastVisit;
  final DateTime createdAt;
  final List<ChildProfileModel> children;

  const BeneficiaryModel({
    required this.beneficiaryId,
    required this.familyId,
    required this.name,
    required this.age,
    required this.gender,
    this.aadhaarNumber,
    this.phoneNumber,
    required this.address,
    required this.wardCode,
    this.pregnancyStatus,
    this.healthHistory = const [],
    this.vaccinationStatus = const {},
    this.lastVisit,
    required this.createdAt,
    this.children = const [],
  });

  bool get isPregnant => pregnancyStatus == 'pregnant';
  bool get isPostnatal => pregnancyStatus == 'post';

  String get pregnancyStatusDisplay {
    switch (pregnancyStatus) {
      case 'pregnant':
        return '🤰 Pregnant';
      case 'post':
        return '👶 Post-natal';
      case 'not':
        return '✅ Not pregnant';
      default:
        return '—';
    }
  }

  String get lastVisitDisplay {
    if (lastVisit == null) return 'Never visited';
    final diff = DateTime.now().difference(lastVisit!);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays} days ago';
  }
}

class ChildProfileModel {
  final String childId;
  final String beneficiaryId;
  final String familyId;
  final String name;
  final DateTime dateOfBirth;
  final String gender;
  final String? bloodGroup;
  final Map<String, bool> vaccinationStatus;
  final String nutritionStatus;
  final DateTime createdAt;
  final List<GrowthMeasurementModel> measurements;

  const ChildProfileModel({
    required this.childId,
    required this.beneficiaryId,
    required this.familyId,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    this.bloodGroup,
    this.vaccinationStatus = const {},
    required this.nutritionStatus,
    required this.createdAt,
    this.measurements = const [],
  });

  int get ageMonths {
    final now = DateTime.now();
    return (now.year - dateOfBirth.year) * 12 +
        (now.month - dateOfBirth.month);
  }

  int get ageYears => DateTime.now().year - dateOfBirth.year;

  String get ageDisplay {
    final months = ageMonths;
    if (months < 12) return '$months months';
    final years = months ~/ 12;
    final rem = months % 12;
    if (rem == 0) return '$years yr';
    return '$years yr $rem mo';
  }

  Color get nutritionColor {
    switch (nutritionStatus) {
      case 'severe':
        return const Color(0xFFF44336);
      case 'moderate':
        return const Color(0xFFFFC107);
      default:
        return const Color(0xFF4CAF50);
    }
  }

  String get nutritionLabel {
    switch (nutritionStatus) {
      case 'severe':
        return 'Severe Malnutrition';
      case 'moderate':
        return 'Moderate Malnutrition';
      default:
        return 'Normal';
    }
  }

  GrowthMeasurementModel? get latestMeasurement =>
      measurements.isNotEmpty ? measurements.last : null;
}

class GrowthMeasurementModel {
  final int? id;
  final String childId;
  final DateTime measuredAt;
  final double weightKg;
  final double heightCm;
  final int ageMonths;
  final String nutritionStatus;
  final String? notes;

  const GrowthMeasurementModel({
    this.id,
    required this.childId,
    required this.measuredAt,
    required this.weightKg,
    required this.heightCm,
    required this.ageMonths,
    required this.nutritionStatus,
    this.notes,
  });

  double get bmi {
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  Color get statusColor {
    switch (nutritionStatus) {
      case 'severe':
        return const Color(0xFFF44336);
      case 'moderate':
        return const Color(0xFFFFC107);
      default:
        return const Color(0xFF4CAF50);
    }
  }
}

// ─── Monthly Report Summary Model ─────────────────────────────────────────

class MonthlyReportSummary {
  final int year;
  final int month;
  final String workerName;
  final String wardCode;
  final String wardName;
  final int totalReports;
  final int totalFeverCases;
  final int totalDiarrheaCases;
  final int totalPregnantWomen;
  final int totalHighRiskPregnancy;
  final int totalAncVisits;
  final int totalMalnourishedChildren;
  final int totalImmunizationsDone;
  final int environmentalRiskFlags;
  final int pendingSyncReports;

  const MonthlyReportSummary({
    required this.year,
    required this.month,
    required this.workerName,
    required this.wardCode,
    required this.wardName,
    required this.totalReports,
    required this.totalFeverCases,
    required this.totalDiarrheaCases,
    required this.totalPregnantWomen,
    required this.totalHighRiskPregnancy,
    required this.totalAncVisits,
    required this.totalMalnourishedChildren,
    required this.totalImmunizationsDone,
    required this.environmentalRiskFlags,
    required this.pendingSyncReports,
  });

  String get monthName {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}

// ─── Visit & Vaccination Models ─────────────────────────────────────────────

class VisitRecordModel {
  final String visitId;
  final String familyId;
  final String beneficiaryId;
  final DateTime visitDate;
  final List<String> symptoms;
  final String? maternalStatus;
  final String? childStatus;
  final String? environmentalRisk;
  final String? notes;
  final double? latitude;
  final double? longitude;
  final String? photoPath;
  final DateTime createdAt;

  const VisitRecordModel({
    required this.visitId,
    required this.familyId,
    required this.beneficiaryId,
    required this.visitDate,
    required this.symptoms,
    this.maternalStatus,
    this.childStatus,
    this.environmentalRisk,
    this.notes,
    this.latitude,
    this.longitude,
    this.photoPath,
    required this.createdAt,
  });
}

class VaccinationRecordModel {
  final int? id;
  final String childId;
  final String vaccineName;
  final int doseNumber;
  final DateTime dateAdministered;
  final String? administeredBy;
  final String? remarks;
  final DateTime? nextDueDate;
  final DateTime createdAt;

  const VaccinationRecordModel({
    this.id,
    required this.childId,
    required this.vaccineName,
    required this.doseNumber,
    required this.dateAdministered,
    this.administeredBy,
    this.remarks,
    this.nextDueDate,
    required this.createdAt,
  });
}
