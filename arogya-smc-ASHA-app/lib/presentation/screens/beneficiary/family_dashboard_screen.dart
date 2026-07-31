import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../data/models/models.dart';
import '../../providers/providers.dart';

class FamilyDashboardScreen extends ConsumerWidget {
  const FamilyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familiesAsync = ref.watch(familiesProvider);
    final highRiskAsync = ref.watch(highRiskFamiliesProvider);
    final pregnantAsync = ref.watch(pregnantMothersProvider);
    final childrenAsync = ref.watch(childrenUnderFiveProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('families.title'.tr()),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            _buildStatsHeader(familiesAsync, highRiskAsync, pregnantAsync, childrenAsync),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                height: 52,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(child: Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Families'))),
                    Tab(child: Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('High-Risk'))),
                    Tab(child: Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Mothers'))),
                    Tab(child: Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Children'))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  _FamilyList(familiesAsync),
                  _FamilyList(highRiskAsync),
                  _BeneficiaryList(pregnantAsync),
                  _ChildList(childrenAsync),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsHeader(AsyncValue families, AsyncValue highRisk, AsyncValue pregnant, AsyncValue children) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      decoration: const BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  label: 'families.title'.tr(),
                  value: families.whenData((v) => v.length.toString()).value ?? '0',
                  icon: Icons.family_restroom_rounded,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _StatItem(
                  label: 'High Risk',
                  value: highRisk.whenData((v) => v.length.toString()).value ?? '0',
                  icon: Icons.warning_amber_rounded,
                  isWarning: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  label: 'families.pregnant'.tr(),
                  value: pregnant.whenData((v) => v.length.toString()).value ?? '0',
                  icon: Icons.pregnant_woman_rounded,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _StatItem(
                  label: 'families.children'.tr(),
                  value: children.whenData((v) => v.length.toString()).value ?? '0',
                  icon: Icons.child_care_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool isWarning;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isWarning ? Colors.orange.withOpacity(0.2) : Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.8),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilyList extends StatelessWidget {
  final AsyncValue<List<FamilyModel>> asyncData;
  const _FamilyList(this.asyncData);

  @override
  Widget build(BuildContext context) {
    return asyncData.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('${'common.error'.tr()}: $e')),
      data: (list) => list.isEmpty 
        ? _buildEmptyState('families.no_families', icon: Icons.family_restroom)
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, i) => _FamilyCard(family: list[i]),
          ),
    );
  }
}

class _FamilyCard extends StatelessWidget {
  final FamilyModel family;
  const _FamilyCard({required this.family});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => context.push(AppRoutes.familyDetail.replaceFirst(':familyId', family.familyId)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.meeting_room_rounded, color: AppColors.primary, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        family.familyName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${'families.head'.tr()}: ${family.headOfFamily}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textLight, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BeneficiaryList extends StatelessWidget {
  final AsyncValue<List<BeneficiaryModel>> asyncData;
  const _BeneficiaryList(this.asyncData);

  @override
  Widget build(BuildContext context) {
    return asyncData.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (list) => list.isEmpty 
        ? const Center(child: Text('No records found'))
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, i) => _BeneficiaryCard(beneficiary: list[i]),
          ),
    );
  }
}

class _BeneficiaryCard extends StatelessWidget {
  final BeneficiaryModel beneficiary;
  const _BeneficiaryCard({required this.beneficiary});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: const Icon(Icons.person_rounded, color: AppColors.primary),
        ),
        title: Text(
          beneficiary.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ),
        subtitle: Text(
          beneficiary.pregnancyStatusDisplay,
          style: const TextStyle(fontSize: 13, fontFamily: 'Poppins'),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () => context.push(AppRoutes.beneficiaryDetail.replaceFirst(':id', beneficiary.beneficiaryId)),
      ),
    );
  }
}

class _ChildList extends StatelessWidget {
  final AsyncValue<List<ChildProfileModel>> asyncData;
  const _ChildList(this.asyncData);

  @override
  Widget build(BuildContext context) {
    return asyncData.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (list) => list.isEmpty 
        ? const Center(child: Text('No records found'))
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, i) => _ChildCard(child: list[i]),
          ),
    );
  }
}

class _ChildCard extends StatelessWidget {
  final ChildProfileModel child;
  const _ChildCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.withOpacity(0.1),
          child: const Icon(Icons.child_care_rounded, color: Colors.blue),
        ),
        title: Text(
          child.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ),
        subtitle: Text(
          'Age: ${child.ageDisplay}',
          style: const TextStyle(fontSize: 13, fontFamily: 'Poppins'),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () => context.push('${AppRoutes.growthChart.replaceFirst(':childId', child.childId)}'),
      ),
    );
  }
}

Widget _buildEmptyState(String messageKey, {IconData icon = Icons.info_outline}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 64, color: AppColors.textLight),
        const SizedBox(height: 16),
        Text(messageKey.tr(), style: const TextStyle(color: AppColors.textSecondary, fontSize: 16, fontFamily: 'Poppins')),
      ],
    ),
  );
}
