import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// ASHA Reports Table
class ReportsTable extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get workerId => text()();
  TextColumn get workerName => text()();
  TextColumn get wardCode => text()();
  DateTimeColumn get reportDate => dateTime()();
  DateTimeColumn get submissionTime => dateTime()();
  
  IntColumn get feverCount => integer()();
  IntColumn get coughCount => integer()();
  IntColumn get diarrheaCount => integer()();
  IntColumn get jaundiceCount => integer()();
  IntColumn get rashCount => integer()();
  TextColumn get diseaseType => text().nullable()();
  
  // JSON fields
  TextColumn get maternalRiskFlags => text()();
  TextColumn get childRiskFlags => text()();
  TextColumn get environmentalFlags => text()();
  
  RealColumn get locationLat => real().nullable()();
  RealColumn get locationLng => real().nullable()();
  TextColumn get photoPaths => text().withDefault(const Constant('[]'))();
  
  IntColumn get syncStatus => integer().withDefault(const Constant(0))(); // 0 pending, 1 synced, 2 failed
  @override Set<Column> get primaryKey => {id};
}

// Families (beneficiaries)
class FamiliesTable extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get familyName => text()();
  TextColumn get headName => text()();
  TextColumn get wardCode => text()();
  TextColumn get address => text()();
  TextColumn get contactNumber => text().nullable()();
  IntColumn get totalMembers => integer()();
  IntColumn get pregnantWomenCount => integer()();
  IntColumn get childrenCount => integer()();
  BoolColumn get highRiskFlag => boolean()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastVisit => dateTime().nullable()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  @override Set<Column> get primaryKey => {id};
}

// Children
class ChildrenTable extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get familyId => text()(); // reference to FamiliesTable
  TextColumn get name => text()();
  DateTimeColumn get dateOfBirth => dateTime()();
  TextColumn get gender => text()();
  TextColumn get bloodGroup => text().nullable()();
  TextColumn get nutritionStatus => text().withDefault(const Constant('normal'))();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  @override Set<Column> get primaryKey => {id};
}

// Growth measurements
class GrowthMeasurementsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get childId => text()();
  DateTimeColumn get measuredAt => dateTime()();
  RealColumn get weightKg => real()();
  RealColumn get heightCm => real()();
  IntColumn get ageMonths => integer()();
  TextColumn get nutritionStatus => text()();
  TextColumn get notes => text().nullable()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
}

// Vaccinations
class VaccinationsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get childId => text()();
  TextColumn get vaccineName => text()();
  IntColumn get doseNumber => integer()();
  DateTimeColumn get dateGiven => dateTime()();
  DateTimeColumn get nextDueDate => dateTime().nullable()();
  TextColumn get remarks => text().nullable()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
}

// Visits
class VisitsTable extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get familyId => text()(); // reference to FamiliesTable
  DateTimeColumn get visitDate => dateTime()();
  TextColumn get healthStatus => text()();
  BoolColumn get fever => boolean()();
  BoolColumn get cough => boolean()();
  BoolColumn get diarrhea => boolean()();
  TextColumn get notes => text().nullable()();
  BoolColumn get followUpRequired => boolean()();
  RealColumn get locationLat => real().nullable()();
  RealColumn get locationLng => real().nullable()();
  TextColumn get photoPath => text().nullable()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  @override Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  ReportsTable,
  FamiliesTable,
  ChildrenTable,
  GrowthMeasurementsTable,
  VaccinationsTable,
  VisitsTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      // Optionally seed some initial data
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // Add the missing disease_type column
        await m.addColumn(reportsTable, reportsTable.diseaseType);
      }
    },
  );

  // DAOs added for sync features
  Future<List<ReportsTableData>> getPendingReports() =>
      (select(reportsTable)..where((t) => t.syncStatus.equals(0))).get();

  Future<void> updateSyncStatus(String id, int status) =>
      (update(reportsTable)..where((t) => t.id.equals(id)))
          .write(ReportsTableCompanion(syncStatus: Value(status)));
          
  Future<ReportsTableData> getReportById(String id) =>
      (select(reportsTable)..where((t) => t.id.equals(id))).getSingle();

  Future<void> insertReport(ReportsTableCompanion report) =>
      into(reportsTable).insert(report);

  Future<List<ReportsTableData>> getReportsByWorker(String workerId) =>
      (select(reportsTable)..where((t) => t.workerId.equals(workerId))).get();

  // Beneficiaries
  Future<void> insertFamily(FamiliesTableCompanion f) => into(familiesTable).insert(f);
  Future<void> updateFamily(FamiliesTableCompanion f) => update(familiesTable).replace(f);
  Future<FamiliesTableData> getFamilyById(String id) =>
      (select(familiesTable)..where((t) => t.id.equals(id))).getSingle();
  Future<void> updateFamilySyncStatus(String id, int status) =>
      (update(familiesTable)..where((t) => t.id.equals(id)))
          .write(FamiliesTableCompanion(syncStatus: Value(status)));

  Future<void> insertChild(ChildrenTableCompanion c) => into(childrenTable).insert(c);
  Future<ChildrenTableData> getChildById(String id) =>
      (select(childrenTable)..where((t) => t.id.equals(id))).getSingle();
  Future<void> updateChildSyncStatus(String id, int status) =>
      (update(childrenTable)..where((t) => t.id.equals(id)))
          .write(ChildrenTableCompanion(syncStatus: Value(status)));

  Future<void> insertVisit(VisitsTableCompanion v) => into(visitsTable).insert(v);
  Future<VisitsTableData> getVisitById(String id) =>
      (select(visitsTable)..where((t) => t.id.equals(id))).getSingle();
  Future<void> updateVisitSyncStatus(String id, int status) =>
      (update(visitsTable)..where((t) => t.id.equals(id)))
          .write(VisitsTableCompanion(syncStatus: Value(status)));

  Future<int> insertVaccination(VaccinationsTableCompanion v) => into(vaccinationsTable).insert(v);
  Future<VaccinationsTableData> getVaccinationById(int id) =>
      (select(vaccinationsTable)..where((t) => t.id.equals(id))).getSingle();
  Future<void> updateVaccinationSyncStatus(int id, int status) =>
      (update(vaccinationsTable)..where((t) => t.id.equals(id)))
          .write(VaccinationsTableCompanion(syncStatus: Value(status)));

  Future<int> insertGrowthMeasurement(GrowthMeasurementsTableCompanion m) async {
    return await into(growthMeasurementsTable).insert(m);
  }
  Future<GrowthMeasurementsTableData> getGrowthMeasurementById(int id) =>
      (select(growthMeasurementsTable)..where((t) => t.id.equals(id))).getSingle();
  Future<void> updateGrowthMeasurementSyncStatus(int id, int status) =>
      (update(growthMeasurementsTable)..where((t) => t.id.equals(id)))
          .write(GrowthMeasurementsTableCompanion(syncStatus: Value(status)));
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'asha_worker_db');
}
