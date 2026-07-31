// lib/data/models/hospital_model.dart

class Doctor {
  final String name;
  final String specialization;
  final String timings;

  const Doctor({
    required this.name,
    required this.specialization,
    required this.timings,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        name: json['name'] as String,
        specialization: json['specialization'] as String,
        timings: json['timings'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'specialization': specialization,
        'timings': timings,
      };
}

class HospitalModel {
  final String id;
  final String name;
  final String ward;
  final String address;
  final String phone;
  final String type;
  final int bedsTotal;
  final int bedsAvailable;
  final bool icuAvailable;
  final int icuBeds;
  final bool ventilatorsAvailable;
  final int ventilators;
  final bool oxygenAvailable;
  final List<String> departments;
  final List<Doctor> doctors;
  final double? latitude;
  final double? longitude;

  const HospitalModel({
    required this.id,
    required this.name,
    required this.ward,
    required this.address,
    required this.phone,
    required this.type,
    required this.bedsTotal,
    required this.bedsAvailable,
    required this.icuAvailable,
    required this.icuBeds,
    required this.ventilatorsAvailable,
    required this.ventilators,
    required this.oxygenAvailable,
    required this.departments,
    required this.doctors,
    this.latitude,
    this.longitude,
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) => HospitalModel(
        id: (json['id'] ?? json['_id'] ?? '').toString(),
        name: (json['name'] ?? 'Unnamed Facility').toString(),
        ward: (json['ward_code'] ?? json['ward'] ?? '').toString(),
        address: (json['address'] ?? '').toString(),
        phone: (json['contact'] ?? json['phone'] ?? '').toString(),
        type: (json['type'] ?? 'Government').toString(),
        bedsTotal: (json['beds_total'] ?? 0) as int,
        bedsAvailable: (json['beds_available'] ?? 0) as int,
        icuAvailable: (json['icu_available'] ?? false) as bool,
        icuBeds: (json['icu_total'] ?? 0) as int,
        ventilatorsAvailable: (json['ventilators_available'] ?? false) as bool,
        ventilators: (json['ventilators_total'] ?? 0) as int,
        oxygenAvailable: (json['oxygen_available'] ?? false) as bool,
        departments: json['specialties'] is List
            ? List<String>.from(json['specialties'] as List)
            : [],
        doctors: json['doctors'] != null
            ? (json['doctors'] as List)
                .map((d) => Doctor.fromJson(d as Map<String, dynamic>))
                .toList()
            : [],
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'ward': ward,
        'address': address,
        'phone': phone,
        'type': type,
        'beds_total': bedsTotal,
        'beds_available': bedsAvailable,
        'icu_available': icuAvailable,
        'icu_total': icuBeds,
        'ventilators_available': ventilatorsAvailable,
        'ventilators_total': ventilators,
        'oxygen_available': oxygenAvailable,
        'specialties': departments,
        'doctors': doctors.map((d) => d.toJson()).toList(),
        'latitude': latitude,
        'longitude': longitude,
      };
}
