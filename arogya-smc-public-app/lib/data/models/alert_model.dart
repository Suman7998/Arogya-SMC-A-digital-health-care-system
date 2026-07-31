// lib/data/models/alert_model.dart

enum AlertType { flu, dengue, vaccination, general }

enum AlertSeverity { low, medium, high }

class AlertModel {
  final String id;
  final String title;
  final String description;
  final AlertType type;
  final AlertSeverity severity;
  final DateTime date;
  final String issuedBy;

  const AlertModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.severity,
    required this.date,
    required this.issuedBy,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) => AlertModel(
        id: (json['id'] ?? json['_id'] ?? '').toString(),
        title: (json['title'] ?? 'Health Alert').toString(),
        description: (json['description'] ?? '').toString(),
        type: _parseAlertType(json['type']?.toString() ?? 'general'),
        severity: _parseSeverity(json['severity']?.toString() ?? 'low'),
        date: json['generated_at'] != null
            ? DateTime.parse(json['generated_at'].toString())
            : DateTime.now(),
        issuedBy: (json['issued_by'] ?? 'SMC').toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'type': type.name,
        'severity': severity.name,
        'generated_at': date.toIso8601String(),
        'issued_by': issuedBy,
      };

  static AlertType _parseAlertType(String type) {
    switch (type.toLowerCase()) {
      case 'dengue':
        return AlertType.dengue;
      case 'flu':
        return AlertType.flu;
      case 'vaccination':
        return AlertType.vaccination;
      default:
        return AlertType.general;
    }
  }

  static AlertSeverity _parseSeverity(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return AlertSeverity.high;
      case 'medium':
        return AlertSeverity.medium;
      default:
        return AlertSeverity.low;
    }
  }
}
