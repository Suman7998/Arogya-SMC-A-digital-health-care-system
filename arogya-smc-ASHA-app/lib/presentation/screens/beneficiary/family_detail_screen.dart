import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/models.dart';
import '../../providers/providers.dart';

class FamilyDetailScreen extends ConsumerWidget {
  final String familyId;
  const FamilyDetailScreen({super.key, required this.familyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyAsync = ref.watch(familyDetailProvider(familyId));
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      body: familyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (family) => family == null 
          ? const Center(child: Text('Family Not Found')) 
          : _FamilyDetailBody(family: family),
      ),
    );
  }
}

class _FamilyDetailBody extends ConsumerWidget {
  final FamilyModel family;
  const _FamilyDetailBody({required this.family});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For household visits, we prioritize the family head or first member ID
    final mainId = family.members.isNotEmpty ? family.members.first.beneficiaryId : family.familyId;

    return CustomScrollView(
      slivers: [
        // --- PREMUM GRADIENT APP BAR ---
        SliverAppBar(
          expandedHeight: 220,
          pinned: true,
          elevation: 0,
          backgroundColor: AppColors.primary,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.headerGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.family_restroom_rounded, color: Colors.white, size: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(family.familyName, 
                              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins')),
                            Text('Family Head: ${family.headOfFamily}', 
                              style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13, fontFamily: 'Poppins')),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on_rounded, color: Colors.white, size: 16),
                        const SizedBox(width: 6),
                        Text(family.wardCode.isNotEmpty ? family.wardCode : 'SOLAPUR NORTH', 
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- QUICK STATS ROW ---
                Row(
                  children: [
                    _StatTile(label: 'Members', value: '${family.memberCount}', icon: Icons.group_rounded, color: AppColors.primary),
                    const SizedBox(width: 12),
                    _StatTile(label: 'Last Visit', value: family.lastVisitDisplay, icon: Icons.history_rounded, color: Colors.orange, isSmall: true),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // --- ACTION BUTTONS (PROFESSIONAL CARDS) ---
                Row(
                  children: [
                    Expanded(
                      child: _ActionCard(
                        title: 'Add Member',
                        subtitle: 'New Person',
                        icon: Icons.person_add_rounded,
                        color: Colors.blue,
                        onTap: () => context.push(AppRoutes.addMember.replaceFirst(':familyId', family.familyId)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ActionCard(
                        title: 'Add Visit',
                        subtitle: 'Checkup',
                        icon: Icons.add_home_work_rounded,
                        color: AppColors.primary,
                        onTap: () => context.push(AppRoutes.addVisit.replaceFirst(':beneficiaryId', mainId)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ActionCard(
                        title: 'Vaccine',
                        subtitle: 'Tracking',
                        icon: Icons.vaccines_rounded,
                        color: Colors.teal,
                        onTap: () => context.push(AppRoutes.vaccination.replaceFirst(':beneficiaryId', mainId)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
                
                // --- MEMBER LIST SECTION ---
                _SectionHeader(title: 'Family Members', icon: Icons.people_outline_rounded),
                const SizedBox(height: 12),
                if (family.members.isEmpty) 
                  const _EmptyState(text: 'No members listed for this family.')
                else
                  ...family.members.map((m) => _MemberItem(member: m)),

                const SizedBox(height: 32),

                // --- VISIT HISTORY SECTION ---
                _SectionHeader(title: 'Recent Visits', icon: Icons.playlist_add_check_rounded),
                const SizedBox(height: 12),
                _VisitHistoryList(beneficiaryId: mainId),

                const SizedBox(height: 32),

                // --- VACCINATION HISTORY SECTION ---
                _SectionHeader(title: 'Vaccination History', icon: Icons.verified_user_outlined),
                const SizedBox(height: 12),
                _VaccinationHistoryList(beneficiaryId: mainId),
                
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final bool isSmall;

  const _StatTile({required this.label, required this.value, required this.icon, required this.color, this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 12),
            Text(value, style: TextStyle(fontSize: isSmall ? 15 : 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({required this.title, required this.subtitle, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 8),
        Text(title.toUpperCase(), 
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 1.1)),
      ],
    );
  }
}

class _MemberItem extends StatelessWidget {
  final BeneficiaryModel member;
  const _MemberItem({required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: member.gender == 'female' ? const Color(0xFFFFF0F3) : const Color(0xFFE3F2FD),
            child: Icon(member.gender == 'female' ? Icons.woman_rounded : Icons.man_rounded, 
              color: member.gender == 'female' ? Colors.pink : Colors.blue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text('Age: ${member.age} | ${member.gender.toUpperCase()}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}

class _VisitHistoryList extends ConsumerWidget {
  final String beneficiaryId;
  const _VisitHistoryList({required this.beneficiaryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visitsAsync = ref.watch(visitsByBeneficiaryProvider(beneficiaryId));
    return visitsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Error: $e'),
      data: (visits) => visits.isEmpty 
        ? const _EmptyState(text: 'No visits recorded yet.')
        : Column(
            children: visits.map((v) => _HistoryCard(
              title: 'Health Status: ${v['health_status']}',
              subtitle: 'Date: ${DateFormat('dd MMM yyyy').format(DateTime.parse(v['visit_date']))}',
              isAlert: v['follow_up_required'] == true,
              icon: Icons.check_circle_outline_rounded,
              color: AppColors.primary,
            )).toList(),
          ),
    );
  }
}

class _VaccinationHistoryList extends ConsumerWidget {
  final String beneficiaryId;
  const _VaccinationHistoryList({required this.beneficiaryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vaccsAsync = ref.watch(vaccinationsByBeneficiaryProvider(beneficiaryId));
    return vaccsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Error: $e'),
      data: (vaccs) => vaccs.isEmpty 
        ? const _EmptyState(text: 'No vaccination records found.')
        : Column(
            children: vaccs.map((v) => _HistoryCard(
              title: '${v['vaccine_name']} (Dose ${v['dose_number']})',
              subtitle: 'Administered: ${DateFormat('dd MMM yyyy').format(DateTime.parse(v['date_given']))}',
              icon: Icons.verified_rounded,
              color: Colors.teal,
            )).toList(),
          ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isAlert;
  final IconData icon;
  final Color color;

  const _HistoryCard({required this.title, required this.subtitle, this.isAlert = false, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isAlert ? Colors.orange.withOpacity(0.3) : Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
          if (isAlert)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Text('FOLLOW UP', style: TextStyle(fontSize: 9, color: Colors.orange, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String text;
  const _EmptyState({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Text(text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 13, fontFamily: 'Poppins')),
    );
  }
}
