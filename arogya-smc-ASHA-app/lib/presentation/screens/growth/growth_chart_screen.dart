import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/providers.dart';
import '../../../data/models/models.dart';

class GrowthChartScreen extends ConsumerStatefulWidget {
  final String childId;

  const GrowthChartScreen({super.key, required this.childId});

  @override
  ConsumerState<GrowthChartScreen> createState() => _GrowthChartScreenState();
}

class _GrowthChartScreenState extends ConsumerState<GrowthChartScreen> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _notesController = TextEditingController();

  void _showAddMeasurement(BuildContext context, String childName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 24, right: 24, top: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Measurement for $childName', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            TextField(
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Weight (kg)', hintText: 'e.g. 10.5'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Height (cm)', hintText: 'e.g. 85.0'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes', hintText: 'Any observations...'),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _saveMeasurement(ref),
              child: const Text('Save Measurement'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _saveMeasurement(WidgetRef ref) async {
    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);

    if (weight != null && height != null) {
      // Determine status (Simple logic for demo)
      String status = 'normal';
      if (weight < 7) status = 'moderate';
      if (weight < 5) status = 'severe';

      final measurement = GrowthMeasurementModel(
        childId: widget.childId,
        measuredAt: DateTime.now(),
        weightKg: weight,
        heightCm: height,
        ageMonths: 24, // In a real app, calculate from DOB
        nutritionStatus: status,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      await ref.read(beneficiaryRepositoryProvider).saveGrowthMeasurement(measurement);
      ref.invalidate(childMeasurementsProvider(widget.childId));
      ref.invalidate(familiesProvider); // Refresh family list so nutrition status updates
      
      if (mounted) Navigator.pop(context);
      _weightController.clear();
      _heightController.clear();
      _notesController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final measurementsAsync = ref.watch(childMeasurementsProvider(widget.childId));

    return Scaffold(
      appBar: AppBar(title: const Text('Growth Tracking')),
      body: measurementsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (measurements) {
          if (measurements.isEmpty) {
            return _buildEmptyState();
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryCard(measurements.last),
                const SizedBox(height: 24),
                _buildChartSection(measurements),
                const SizedBox(height: 24),
                _buildDataTable(measurements),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddMeasurement(context, 'Child'),
        icon: const Icon(Icons.add),
        label: const Text('Add Measurement'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildSummaryCard(GrowthMeasurementModel last) {
    return Card(
      elevation: 4,
      color: last.statusColor.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: last.statusColor.withOpacity(0.3), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: last.statusColor, shape: BoxShape.circle),
              child: const Icon(Icons.fitness_center, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Latest Status', style: TextStyle(color: AppColors.textSecondary)),
                  Text(
                    last.nutritionStatus.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: last.statusColor),
                  ),
                  Text('Updated on ${DateFormat('dd MMM yyyy').format(last.measuredAt)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartSection(List<GrowthMeasurementModel> measurements) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Weight Trend (kg)', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Container(
          height: 250,
          padding: const EdgeInsets.only(right: 20, top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
          ),
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: true, drawVerticalLine: false),
              titlesData: FlTitlesData(
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (val, meta) {
                      if (val.toInt() >= 0 && val.toInt() < measurements.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(DateFormat('MMM').format(measurements[val.toInt()].measuredAt),
                              style: const TextStyle(fontSize: 10)),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: measurements.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.weightKg)).toList(),
                  isCurved: true,
                  color: AppColors.primary,
                  barWidth: 4,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(show: true, color: AppColors.primary.withOpacity(0.1)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable(List<GrowthMeasurementModel> measurements) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Previous Records', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: DataTable(
            columnSpacing: 20,
            columns: const [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Wt (kg)')),
              DataColumn(label: Text('Ht (cm)')),
              DataColumn(label: Text('Status')),
            ],
            rows: measurements.reversed.map((m) {
              return DataRow(cells: [
                DataCell(Text(DateFormat('dd/MM').format(m.measuredAt))),
                DataCell(Text(m.weightKg.toString())),
                DataCell(Text(m.heightCm.toString())),
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(color: m.statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                    child: Text(m.nutritionStatus[0].toUpperCase(), style: TextStyle(color: m.statusColor, fontWeight: FontWeight.bold)),
                  ),
                ),
              ]);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.show_chart, size: 60, color: AppColors.textLight),
          const SizedBox(height: 16),
          const Text('No growth data recorded yet.', style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
