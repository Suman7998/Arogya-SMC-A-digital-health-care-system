import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:printing/printing.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/providers.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/report_generation_service.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  DateTime _selectedMonth = DateTime.now();
  bool _isGenerating = false;
  DetailedMonthlyReport? _previewReport;

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  Future<void> _loadSummary() async {
    final worker = ref.read(currentWorkerProvider);
    if (worker == null) return;

    final service = ReportGenerationService();
    final reportData = await service.getDetailedMonthlyReport(_selectedMonth.year, _selectedMonth.month, worker);
    setState(() => _previewReport = reportData);
  }

  Future<void> _generateAndDownload() async {
    if (_previewReport == null) return;

    setState(() => _isGenerating = true);
    try {
      final service = ReportGenerationService();
      final file = await service.generateDetailedPDF(_previewReport!);
      
      if (mounted) {
        await Printing.sharePdf(bytes: await file.readAsBytes(), filename: 'ASHA_Report_${_selectedMonth.month}_${_selectedMonth.year}.pdf');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error generating report: $e')));
      }
    } finally {
      setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('reports.title'.tr()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
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
                  Text(
                    'reports.title'.tr(),
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Monthly performance & data summary',
                    style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.9), fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 20),
                  _buildMonthPicker(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if (_previewReport != null) _buildSummaryPreview() else const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator())),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))],
        ),
        child: ElevatedButton.icon(
          onPressed: _isGenerating ? null : _generateAndDownload,
          icon: _isGenerating 
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
              : const Icon(Icons.picture_as_pdf_outlined),
          label: Text(_isGenerating ? 'Generating PDF...' : 'Download Full Monthly Report'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
      ),
    );
  }

  Widget _buildMonthPicker() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 28),
        title: Text(
          DateFormat('MMMM yyyy').format(_selectedMonth),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        trailing: const Icon(Icons.arrow_drop_down_circle_rounded, color: Colors.white),
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: _selectedMonth,
            firstDate: DateTime(2020),
            lastDate: DateTime.now(),
          );
          if (date != null) {
            setState(() => _selectedMonth = date);
            _loadSummary();
          }
        },
      ),
    );
  }

  Widget _buildSummaryPreview() {
    final r = _previewReport!;
    
    // Aggregate for preview
    final totalVisits = r.dailySummaries.fold<int>(0, (sum, ds) => sum + ds.visitCount);
    final totalFever = r.dailySummaries.fold<int>(0, (sum, ds) => sum + ds.feverCases);
    final totalAnc = r.dailySummaries.fold<int>(0, (sum, ds) => sum + ds.maternalRisks);
    final totalChild = r.dailySummaries.fold<int>(0, (sum, ds) => sum + ds.childRisks);

    return Column(
      children: [
        _buildStatTile('reports.total_visits'.tr(), totalVisits.toString(), Icons.assignment),
        _buildStatTile('reports.fever_cases'.tr(), totalFever.toString(), Icons.thermostat),
        _buildStatTile('reports.anc_visits'.tr(), totalAnc.toString(), Icons.pregnant_woman),
        _buildStatTile('reports.child_health'.tr(), totalChild.toString(), Icons.child_care),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildStatTile(String label, String value, IconData icon) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.primaryLighter, borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: AppColors.primary, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontFamily: 'Poppins'),
              ),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary, fontFamily: 'Poppins'),
            ),
          ],
        ),
      ),
    );
  }
}
