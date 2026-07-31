// lib/data/models/ward_model.dart

class WardModel {
  final String id;
  final String wardNo;
  final String wardName;
  final String? area;

  const WardModel({
    required this.id,
    required this.wardNo,
    required this.wardName,
    this.area,
  });

  factory WardModel.fromJson(Map<String, dynamic> json) => WardModel(
        id: (json['id'] ?? json['_id'] ?? '').toString(),
        wardNo: (json['ward_no'] ?? json['wardNo'] ?? json['number'] ?? '').toString(),
        wardName: (json['ward_name'] ?? json['wardName'] ?? json['name'] ?? 'Ward').toString(),
        area: json['area']?.toString(),
      );
}
