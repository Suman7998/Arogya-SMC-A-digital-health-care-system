// lib/data/models/announcement_model.dart

class AnnouncementModel {
  final String id;
  final String title;
  final String subtitle;
  final String gradientStart; // Hex color string
  final String gradientEnd;
  final String iconName; // Material icon name as string
  final String? actionUrl;

  const AnnouncementModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.gradientStart,
    required this.gradientEnd,
    required this.iconName,
    this.actionUrl,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      AnnouncementModel(
        id: json['id'] as String,
        title: json['title'] as String,
        subtitle: json['subtitle'] as String,
        gradientStart: json['gradient_start'] as String,
        gradientEnd: json['gradient_end'] as String,
        iconName: json['icon'] as String,
        actionUrl: json['action_url'] as String?,
      );
}
