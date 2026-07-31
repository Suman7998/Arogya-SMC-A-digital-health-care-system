// lib/data/models/advisory_model.dart

class AdvisoryModel {
  final String id;
  final String title;
  final String description;
  final String issuedBy;
  final String? date;
  final String? category;

  const AdvisoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.issuedBy,
    this.date,
    this.category,
  });

  factory AdvisoryModel.fromJson(Map<String, dynamic> json) => AdvisoryModel(
        id: (json['id'] ?? json['_id'] ?? '').toString(),
        title: (json['title'] ?? 'Advisory').toString(),
        description: (json['description'] ?? '').toString(),
        issuedBy: (json['issued_by'] ?? 'SMC').toString(),
        date: json['published_at']?.toString(),
        category: json['severity']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'issued_by': issuedBy,
        'published_at': date,
        'severity': category,
      };
}
