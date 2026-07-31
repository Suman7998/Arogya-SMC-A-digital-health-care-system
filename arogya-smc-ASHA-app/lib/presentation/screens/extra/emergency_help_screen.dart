import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';

class EmergencyHelpScreen extends StatelessWidget {
  const EmergencyHelpScreen({super.key});

  Future<void> _makeCall(String number) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Help'),
        backgroundColor: AppColors.criticalRed,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Emergency Contacts',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap any contact to call immediately.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 24),
            _EmergencyCard(
              title: 'Ambulance',
              subtitle: 'Common Dispatch Service',
              number: '108',
              icon: Icons.airport_shuttle_rounded,
              color: AppColors.criticalRed,
              onTap: () => _makeCall('108'),
            ),
            _EmergencyCard(
              title: 'Police',
              subtitle: 'Emergency Support',
              number: '100',
              icon: Icons.local_police_rounded,
              color: Colors.blue[800]!,
              onTap: () => _makeCall('100'),
            ),
            _EmergencyCard(
              title: 'Fire Brigade',
              subtitle: 'Fire Hazards',
              number: '101',
              icon: Icons.fire_truck_rounded,
              color: Colors.orange[800]!,
              onTap: () => _makeCall('101'),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Local Supervisor',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 12),
            _EmergencyCard(
              title: 'SMC Health Supervisor',
              subtitle: 'Sadar Bazaar Area Office',
              number: '0217-2740300',
              icon: Icons.person_pin_rounded,
              color: AppColors.primary,
              onTap: () => _makeCall('02172740300'),
            ),
            _EmergencyCard(
              title: 'Medical Officer',
              subtitle: 'District Hospital Solapur',
              number: '0217-2313101',
              icon: Icons.medical_services_rounded,
              color: AppColors.primary,
              onTap: () => _makeCall('02172313101'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmergencyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String number;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _EmergencyCard({
    required this.title,
    required this.subtitle,
    required this.number,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 4),
            Text(
              number,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.call, color: Colors.white, size: 20),
        ),
        onTap: onTap,
      ),
    );
  }
}
