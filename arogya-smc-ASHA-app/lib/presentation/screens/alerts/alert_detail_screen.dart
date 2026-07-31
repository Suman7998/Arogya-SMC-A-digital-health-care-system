import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/models.dart';

class AlertDetailScreen extends StatelessWidget {
  final AlertModel alert;

  const AlertDetailScreen({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    // descriptionMarathi holds Source, descriptionHindi holds URL
    final sourceName = (alert.descriptionMarathi?.isNotEmpty == true) ? alert.descriptionMarathi! : 'Public Health Source';
    final sourceUrl = alert.descriptionHindi;

    return Scaffold(
      appBar: AppBar(title: const Text('Alert Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: alert.severityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    alert.severity.toUpperCase(),
                    style: TextStyle(color: alert.severityColor, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    alert.type,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(alert.title, style: AppTextStyles.displayLarge.copyWith(color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Text(
              'Issued on: ${DateFormat('dd MMM yyyy, hh:mm a').format(alert.generatedAt)}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.black54),
                const SizedBox(width: 4),
                Text(
                  'Scope: ${alert.wardCode ?? "Solapur & Surrounding Districts"}',
                  style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Divider(height: 32),
            Text(alert.description, style: AppTextStyles.bodyRegular.copyWith(fontSize: 16, height: 1.6)),
            const SizedBox(height: 32),
            
            _buildAdvisorySection(
              title: 'Source: $sourceName',
              actions: [
                'Ensure to verify information locally.',
                'Prioritize Solapur guidelines if conflicts exist.',
              ],
            ),
            
            if (sourceUrl != null && sourceUrl.isNotEmpty) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final uri = Uri.parse(sourceUrl);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  },
                  icon: const Icon(Icons.open_in_browser),
                  label: const Text('View Full Source'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildAdvisorySection({required String title, required List<String> actions}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue)),
          const SizedBox(height: 12),
          ...actions.map((a) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(child: Text(a)),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
