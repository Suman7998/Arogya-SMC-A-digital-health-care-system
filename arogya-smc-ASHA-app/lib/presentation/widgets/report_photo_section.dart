import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/image_utility.dart';
import '../providers/providers.dart';

class ReportPhotoSection extends ConsumerWidget {
  const ReportPhotoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportWizardProvider);
    final utility = ImageUtilityService();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Visit Photos', style: AppTextStyles.cardTitle),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    final path = await utility.capturePhoto();
                    if (path != null) ref.read(reportWizardProvider.notifier).addPhoto(path);
                  },
                  icon: const Icon(Icons.camera_alt, color: AppColors.primary),
                ),
                IconButton(
                  onPressed: () async {
                    final path = await utility.pickFromGallery();
                    if (path != null) ref.read(reportWizardProvider.notifier).addPhoto(path);
                  },
                  icon: const Icon(Icons.photo_library, color: AppColors.primary),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (state.photoPaths.isEmpty)
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
            ),
            child: const Center(child: Text('Add photos of hazards or visits', style: TextStyle(color: AppColors.textLight))),
          )
        else
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.photoPaths.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(File(state.photoPaths[index]), height: 120, width: 120, fit: BoxFit.cover),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => ref.read(reportWizardProvider.notifier).removePhoto(index),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                            child: const Icon(Icons.close, size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
