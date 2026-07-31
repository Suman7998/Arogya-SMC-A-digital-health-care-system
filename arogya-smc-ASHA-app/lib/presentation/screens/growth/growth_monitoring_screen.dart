import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/providers.dart';

class GrowthMonitoringScreen extends ConsumerWidget {
  const GrowthMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childrenAsync = ref.watch(childrenUnderFiveProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Growth Monitoring'),
      ),
      body: childrenAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (children) {
          if (children.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.child_care, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No children under 5 years found.', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.push(AppRoutes.beneficiaryList),
                    icon: const Icon(Icons.family_restroom),
                    label: const Text('Go to Families to Add Member'),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: children.length,
            itemBuilder: (context, index) {
              final child = children[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: child.gender == 'male' ? Colors.blue.shade50 : Colors.pink.shade50,
                    child: Text(child.gender == 'male' ? '👦' : '👧'),
                  ),
                  title: Text(child.name, style: AppTextStyles.cardTitle),
                  subtitle: Text('Age: ${child.ageDisplay}'),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: child.nutritionColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      child.nutritionStatus.toUpperCase(),
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: child.nutritionColor),
                    ),
                  ),
                  onTap: () => context.push(
                    AppRoutes.growthChart.replaceFirst(':childId', child.childId),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
