import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import '../models/models.dart';
import '../database/app_database.dart';
import '../../main.dart';
import 'package:intl/intl.dart';

class ReportGenerationService {
  Future<DetailedMonthlyReport> getDetailedMonthlyReport(int year, int month, AshaWorker worker) async {
    final allReports = await appDatabase.getReportsByWorker(worker.id);
    
    // Filter for the specific month/year
    final monthlyReports = allReports.where((r) => 
      r.reportDate.year == year && r.reportDate.month == month).toList();

    // Group by Day
    final Map<int, List<ReportsTableData>> dailyGroups = {};
    for (var r in monthlyReports) {
      dailyGroups.putIfAbsent(r.reportDate.day, () => []).add(r);
    }

    final List<DailySummary> dailySummaries = [];
    final List<WeeklySummary> weeklySummaries = [];
    
    // Calculate Daily Summaries
    final daysInMonth = DateTime(year, month + 1, 0).day;
    for (int d = 1; d <= daysInMonth; d++) {
      final dayReports = dailyGroups[d] ?? [];
      int fever = 0;
      int maternalRisks = 0;
      int childRisks = 0;
      
      for (final r in dayReports) {
        final syndromic = SyndromicData(
          feverCount: r.feverCount,
          coughCount: r.coughCount,
          diarrheaCount: r.diarrheaCount,
          jaundiceCount: r.jaundiceCount,
          rashCount: r.rashCount,
        );
        final maternal = MaternalHealthData.fromJsonString(r.maternalRiskFlags);
        final child = ChildHealthData.fromJsonString(r.childRiskFlags);
        
        fever += syndromic.feverCount;
        if (maternal.highRiskPregnancy || maternal.postnatalComplications || maternal.noAncVisit) maternalRisks++;
        if (child.malnourished || child.immunizationOverdue || child.sickChild) childRisks++;
      }
      
      dailySummaries.add(DailySummary(
        day: d,
        visitCount: dayReports.length,
        feverCases: fever,
        maternalRisks: maternalRisks,
        childRisks: childRisks,
      ));
    }

    // Calculate Weekly Summaries
    for (int w = 0; w < 5; w++) {
      int start = w * 7 + 1;
      int end = (w + 1) * 7;
      if (start > daysInMonth) break;
      if (end > daysInMonth) end = daysInMonth;
      
      final weekDays = dailySummaries.where((ds) => ds.day >= start && ds.day <= end);
      weeklySummaries.add(WeeklySummary(
        weekNumber: w + 1,
        totalVisits: weekDays.fold(0, (sum, ds) => sum + ds.visitCount),
        totalFever: weekDays.fold(0, (sum, ds) => sum + ds.feverCases),
        totalMaternalRisks: weekDays.fold(0, (sum, ds) => sum + ds.maternalRisks),
      ));
    }

    final monthName = DateFormat('MMMM').format(DateTime(year, month));

    // Yearly Aggregation (Optional/If data available)
    final yearlyReports = allReports.where((r) => r.reportDate.year == year).toList();
    int yellowReports = yearlyReports.where((r) => r.syncStatus == 0).length;

    return DetailedMonthlyReport(
      year: year,
      month: month,
      monthName: monthName,
      workerName: worker.fullName,
      wardName: worker.wardName,
      wardCode: worker.wardCode,
      dailySummaries: dailySummaries,
      weeklySummaries: weeklySummaries,
      yearlyTotalVisits: yearlyReports.length,
      yearlyPending: yellowReports,
    );
  }

  Future<File> generateDetailedPDF(DetailedMonthlyReport report) async {
    final pdf = pw.Document();

    final headerStyle = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10);
    final cellStyle = const pw.TextStyle(fontSize: 9);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => pw.Column(
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('SOLAPUR MUNICIPAL CORPORATION', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
                    pw.Text('PUBLIC HEALTH DEPARTMENT - ASHA PORTAL', style: pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.Text('OFFICIAL RECORD', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.grey700)),
              ],
            ),
            pw.Divider(thickness: 2),
            pw.SizedBox(height: 10),
          ],
        ),
        build: (pw.Context context) {
          return [
            pw.Text('MONTHLY PERFORMANCE REPORT', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 13, decoration: pw.TextDecoration.underline)),
            pw.SizedBox(height: 12),
            
            // Info Table
            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              children: [
                pw.TableRow(children: [
                  _pcell('Reporting Month', headerStyle),
                  _pcell('${report.monthName} ${report.year}', cellStyle),
                  _pcell('ASHA Worker Name', headerStyle),
                  _pcell(report.workerName, cellStyle),
                ]),
                pw.TableRow(children: [
                   _pcell('Ward Name', headerStyle),
                   _pcell(report.wardName, cellStyle),
                   _pcell('Ward Code', headerStyle),
                   _pcell(report.wardCode, cellStyle),
                ]),
              ],
            ),
            
            pw.SizedBox(height: 24),
            pw.Text('1. DAILY ACTIVITY SUMMARY', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
            pw.SizedBox(height: 8),
            
            // Daily Table
            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    _pcell('Day', headerStyle),
                    _pcell('Total Visits', headerStyle),
                    _pcell('Fever Cases', headerStyle),
                    _pcell('Maternal Risks', headerStyle),
                    _pcell('Child Risks', headerStyle),
                  ],
                ),
                ...report.dailySummaries.map((ds) => pw.TableRow(
                  children: [
                    _pcell(ds.day.toString(), cellStyle),
                    _pcell(ds.visitCount.toString(), cellStyle),
                    _pcell(ds.feverCases.toString(), cellStyle),
                    _pcell(ds.maternalRisks.toString(), cellStyle),
                    _pcell(ds.childRisks.toString(), cellStyle),
                  ],
                )).toList(),
              ],
            ),
            
            pw.SizedBox(height: 24),
            pw.Text('2. WEEKLY AGGREGATES', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
            pw.SizedBox(height: 8),
            
            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    _pcell('Week No.', headerStyle),
                    _pcell('Total Visits', headerStyle),
                    _pcell('Total Fever Cases', headerStyle),
                    _pcell('Maternal Risks', headerStyle),
                  ],
                ),
                ...report.weeklySummaries.map((ws) => pw.TableRow(
                  children: [
                    _pcell('Week ${ws.weekNumber}', cellStyle),
                    _pcell(ws.totalVisits.toString(), cellStyle),
                    _pcell(ws.totalFever.toString(), cellStyle),
                    _pcell(ws.totalMaternalRisks.toString(), cellStyle),
                  ],
                )).toList(),
              ],
            ),
            
            pw.SizedBox(height: 24),
            pw.Text('3. YEARLY CUMULATIVE SUMMARY (${report.year})', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
            pw.SizedBox(height: 8),
            
            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.blue100),
                  children: [
                    _pcell('Yearly Metric', headerStyle),
                    _pcell('Value', headerStyle),
                  ],
                ),
                pw.TableRow(children: [
                  _pcell('Total Annual Visits Recorded', cellStyle),
                  _pcell(report.yearlyTotalVisits.toString(), cellStyle),
                ]),
                pw.TableRow(children: [
                  _pcell('Total Pending Sync (Annual)', cellStyle),
                  _pcell(report.yearlyPending.toString(), cellStyle),
                ]),
              ],
            ),
            
            pw.SizedBox(height: 48),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.SizedBox(width: 100, child: pw.Divider()),
                    pw.Text('ASHA Worker Signature', style: const pw.TextStyle(fontSize: 8)),
                  ],
                ),
                pw.Column(
                  children: [
                    pw.SizedBox(width: 100, child: pw.Divider()),
                    pw.Text('Medical Officer Stamp', style: const pw.TextStyle(fontSize: 8)),
                  ],
                ),
              ],
            ),
          ];
        },
        footer: (context) => pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text('Page ${context.pageNumber} of ${context.pagesCount}', style: const pw.TextStyle(fontSize: 8)),
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/ASHA_Report_${report.month}_${report.year}.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  pw.Widget _pcell(String text, pw.TextStyle style) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(text, style: style, textAlign: pw.TextAlign.center),
    );
  }

}

class DetailedMonthlyReport {
  final int year;
  final int month;
  final String monthName;
  final String workerName;
  final String wardName;
  final String wardCode;
  final List<DailySummary> dailySummaries;
  final List<WeeklySummary> weeklySummaries;
  final int yearlyTotalVisits;
  final int yearlyPending;

  DetailedMonthlyReport({
    required this.year,
    required this.month,
    required this.monthName,
    required this.workerName,
    required this.wardName,
    required this.wardCode,
    required this.dailySummaries,
    required this.weeklySummaries,
    required this.yearlyTotalVisits,
    required this.yearlyPending,
  });
}

class DailySummary {
  final int day;
  final int visitCount;
  final int feverCases;
  final int maternalRisks;
  final int childRisks;

  DailySummary({
    required this.day,
    required this.visitCount,
    required this.feverCases,
    required this.maternalRisks,
    required this.childRisks,
  });
}

class WeeklySummary {
  final int weekNumber;
  final int totalVisits;
  final int totalFever;
  final int totalMaternalRisks;

  WeeklySummary({
    required this.weekNumber,
    required this.totalVisits,
    required this.totalFever,
    required this.totalMaternalRisks,
  });
}
