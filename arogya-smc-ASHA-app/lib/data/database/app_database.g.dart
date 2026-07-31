// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ReportsTableTable extends ReportsTable
    with TableInfo<$ReportsTableTable, ReportsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workerIdMeta =
      const VerificationMeta('workerId');
  @override
  late final GeneratedColumn<String> workerId = GeneratedColumn<String>(
      'worker_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workerNameMeta =
      const VerificationMeta('workerName');
  @override
  late final GeneratedColumn<String> workerName = GeneratedColumn<String>(
      'worker_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wardCodeMeta =
      const VerificationMeta('wardCode');
  @override
  late final GeneratedColumn<String> wardCode = GeneratedColumn<String>(
      'ward_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reportDateMeta =
      const VerificationMeta('reportDate');
  @override
  late final GeneratedColumn<DateTime> reportDate = GeneratedColumn<DateTime>(
      'report_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _submissionTimeMeta =
      const VerificationMeta('submissionTime');
  @override
  late final GeneratedColumn<DateTime> submissionTime =
      GeneratedColumn<DateTime>('submission_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _feverCountMeta =
      const VerificationMeta('feverCount');
  @override
  late final GeneratedColumn<int> feverCount = GeneratedColumn<int>(
      'fever_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _coughCountMeta =
      const VerificationMeta('coughCount');
  @override
  late final GeneratedColumn<int> coughCount = GeneratedColumn<int>(
      'cough_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _diarrheaCountMeta =
      const VerificationMeta('diarrheaCount');
  @override
  late final GeneratedColumn<int> diarrheaCount = GeneratedColumn<int>(
      'diarrhea_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _jaundiceCountMeta =
      const VerificationMeta('jaundiceCount');
  @override
  late final GeneratedColumn<int> jaundiceCount = GeneratedColumn<int>(
      'jaundice_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _rashCountMeta =
      const VerificationMeta('rashCount');
  @override
  late final GeneratedColumn<int> rashCount = GeneratedColumn<int>(
      'rash_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _diseaseTypeMeta =
      const VerificationMeta('diseaseType');
  @override
  late final GeneratedColumn<String> diseaseType = GeneratedColumn<String>(
      'disease_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _maternalRiskFlagsMeta =
      const VerificationMeta('maternalRiskFlags');
  @override
  late final GeneratedColumn<String> maternalRiskFlags =
      GeneratedColumn<String>('maternal_risk_flags', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _childRiskFlagsMeta =
      const VerificationMeta('childRiskFlags');
  @override
  late final GeneratedColumn<String> childRiskFlags = GeneratedColumn<String>(
      'child_risk_flags', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _environmentalFlagsMeta =
      const VerificationMeta('environmentalFlags');
  @override
  late final GeneratedColumn<String> environmentalFlags =
      GeneratedColumn<String>('environmental_flags', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationLatMeta =
      const VerificationMeta('locationLat');
  @override
  late final GeneratedColumn<double> locationLat = GeneratedColumn<double>(
      'location_lat', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _locationLngMeta =
      const VerificationMeta('locationLng');
  @override
  late final GeneratedColumn<double> locationLng = GeneratedColumn<double>(
      'location_lng', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _photoPathsMeta =
      const VerificationMeta('photoPaths');
  @override
  late final GeneratedColumn<String> photoPaths = GeneratedColumn<String>(
      'photo_paths', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workerId,
        workerName,
        wardCode,
        reportDate,
        submissionTime,
        feverCount,
        coughCount,
        diarrheaCount,
        jaundiceCount,
        rashCount,
        diseaseType,
        maternalRiskFlags,
        childRiskFlags,
        environmentalFlags,
        locationLat,
        locationLng,
        photoPaths,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reports_table';
  @override
  VerificationContext validateIntegrity(Insertable<ReportsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('worker_id')) {
      context.handle(_workerIdMeta,
          workerId.isAcceptableOrUnknown(data['worker_id']!, _workerIdMeta));
    } else if (isInserting) {
      context.missing(_workerIdMeta);
    }
    if (data.containsKey('worker_name')) {
      context.handle(
          _workerNameMeta,
          workerName.isAcceptableOrUnknown(
              data['worker_name']!, _workerNameMeta));
    } else if (isInserting) {
      context.missing(_workerNameMeta);
    }
    if (data.containsKey('ward_code')) {
      context.handle(_wardCodeMeta,
          wardCode.isAcceptableOrUnknown(data['ward_code']!, _wardCodeMeta));
    } else if (isInserting) {
      context.missing(_wardCodeMeta);
    }
    if (data.containsKey('report_date')) {
      context.handle(
          _reportDateMeta,
          reportDate.isAcceptableOrUnknown(
              data['report_date']!, _reportDateMeta));
    } else if (isInserting) {
      context.missing(_reportDateMeta);
    }
    if (data.containsKey('submission_time')) {
      context.handle(
          _submissionTimeMeta,
          submissionTime.isAcceptableOrUnknown(
              data['submission_time']!, _submissionTimeMeta));
    } else if (isInserting) {
      context.missing(_submissionTimeMeta);
    }
    if (data.containsKey('fever_count')) {
      context.handle(
          _feverCountMeta,
          feverCount.isAcceptableOrUnknown(
              data['fever_count']!, _feverCountMeta));
    } else if (isInserting) {
      context.missing(_feverCountMeta);
    }
    if (data.containsKey('cough_count')) {
      context.handle(
          _coughCountMeta,
          coughCount.isAcceptableOrUnknown(
              data['cough_count']!, _coughCountMeta));
    } else if (isInserting) {
      context.missing(_coughCountMeta);
    }
    if (data.containsKey('diarrhea_count')) {
      context.handle(
          _diarrheaCountMeta,
          diarrheaCount.isAcceptableOrUnknown(
              data['diarrhea_count']!, _diarrheaCountMeta));
    } else if (isInserting) {
      context.missing(_diarrheaCountMeta);
    }
    if (data.containsKey('jaundice_count')) {
      context.handle(
          _jaundiceCountMeta,
          jaundiceCount.isAcceptableOrUnknown(
              data['jaundice_count']!, _jaundiceCountMeta));
    } else if (isInserting) {
      context.missing(_jaundiceCountMeta);
    }
    if (data.containsKey('rash_count')) {
      context.handle(_rashCountMeta,
          rashCount.isAcceptableOrUnknown(data['rash_count']!, _rashCountMeta));
    } else if (isInserting) {
      context.missing(_rashCountMeta);
    }
    if (data.containsKey('disease_type')) {
      context.handle(
          _diseaseTypeMeta,
          diseaseType.isAcceptableOrUnknown(
              data['disease_type']!, _diseaseTypeMeta));
    }
    if (data.containsKey('maternal_risk_flags')) {
      context.handle(
          _maternalRiskFlagsMeta,
          maternalRiskFlags.isAcceptableOrUnknown(
              data['maternal_risk_flags']!, _maternalRiskFlagsMeta));
    } else if (isInserting) {
      context.missing(_maternalRiskFlagsMeta);
    }
    if (data.containsKey('child_risk_flags')) {
      context.handle(
          _childRiskFlagsMeta,
          childRiskFlags.isAcceptableOrUnknown(
              data['child_risk_flags']!, _childRiskFlagsMeta));
    } else if (isInserting) {
      context.missing(_childRiskFlagsMeta);
    }
    if (data.containsKey('environmental_flags')) {
      context.handle(
          _environmentalFlagsMeta,
          environmentalFlags.isAcceptableOrUnknown(
              data['environmental_flags']!, _environmentalFlagsMeta));
    } else if (isInserting) {
      context.missing(_environmentalFlagsMeta);
    }
    if (data.containsKey('location_lat')) {
      context.handle(
          _locationLatMeta,
          locationLat.isAcceptableOrUnknown(
              data['location_lat']!, _locationLatMeta));
    }
    if (data.containsKey('location_lng')) {
      context.handle(
          _locationLngMeta,
          locationLng.isAcceptableOrUnknown(
              data['location_lng']!, _locationLngMeta));
    }
    if (data.containsKey('photo_paths')) {
      context.handle(
          _photoPathsMeta,
          photoPaths.isAcceptableOrUnknown(
              data['photo_paths']!, _photoPathsMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReportsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReportsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}worker_id'])!,
      workerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}worker_name'])!,
      wardCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ward_code'])!,
      reportDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}report_date'])!,
      submissionTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}submission_time'])!,
      feverCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fever_count'])!,
      coughCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cough_count'])!,
      diarrheaCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}diarrhea_count'])!,
      jaundiceCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}jaundice_count'])!,
      rashCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rash_count'])!,
      diseaseType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}disease_type']),
      maternalRiskFlags: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}maternal_risk_flags'])!,
      childRiskFlags: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}child_risk_flags'])!,
      environmentalFlags: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}environmental_flags'])!,
      locationLat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}location_lat']),
      locationLng: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}location_lng']),
      photoPaths: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_paths'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $ReportsTableTable createAlias(String alias) {
    return $ReportsTableTable(attachedDatabase, alias);
  }
}

class ReportsTableData extends DataClass
    implements Insertable<ReportsTableData> {
  final String id;
  final String workerId;
  final String workerName;
  final String wardCode;
  final DateTime reportDate;
  final DateTime submissionTime;
  final int feverCount;
  final int coughCount;
  final int diarrheaCount;
  final int jaundiceCount;
  final int rashCount;
  final String? diseaseType;
  final String maternalRiskFlags;
  final String childRiskFlags;
  final String environmentalFlags;
  final double? locationLat;
  final double? locationLng;
  final String photoPaths;
  final int syncStatus;
  const ReportsTableData(
      {required this.id,
      required this.workerId,
      required this.workerName,
      required this.wardCode,
      required this.reportDate,
      required this.submissionTime,
      required this.feverCount,
      required this.coughCount,
      required this.diarrheaCount,
      required this.jaundiceCount,
      required this.rashCount,
      this.diseaseType,
      required this.maternalRiskFlags,
      required this.childRiskFlags,
      required this.environmentalFlags,
      this.locationLat,
      this.locationLng,
      required this.photoPaths,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['worker_id'] = Variable<String>(workerId);
    map['worker_name'] = Variable<String>(workerName);
    map['ward_code'] = Variable<String>(wardCode);
    map['report_date'] = Variable<DateTime>(reportDate);
    map['submission_time'] = Variable<DateTime>(submissionTime);
    map['fever_count'] = Variable<int>(feverCount);
    map['cough_count'] = Variable<int>(coughCount);
    map['diarrhea_count'] = Variable<int>(diarrheaCount);
    map['jaundice_count'] = Variable<int>(jaundiceCount);
    map['rash_count'] = Variable<int>(rashCount);
    if (!nullToAbsent || diseaseType != null) {
      map['disease_type'] = Variable<String>(diseaseType);
    }
    map['maternal_risk_flags'] = Variable<String>(maternalRiskFlags);
    map['child_risk_flags'] = Variable<String>(childRiskFlags);
    map['environmental_flags'] = Variable<String>(environmentalFlags);
    if (!nullToAbsent || locationLat != null) {
      map['location_lat'] = Variable<double>(locationLat);
    }
    if (!nullToAbsent || locationLng != null) {
      map['location_lng'] = Variable<double>(locationLng);
    }
    map['photo_paths'] = Variable<String>(photoPaths);
    map['sync_status'] = Variable<int>(syncStatus);
    return map;
  }

  ReportsTableCompanion toCompanion(bool nullToAbsent) {
    return ReportsTableCompanion(
      id: Value(id),
      workerId: Value(workerId),
      workerName: Value(workerName),
      wardCode: Value(wardCode),
      reportDate: Value(reportDate),
      submissionTime: Value(submissionTime),
      feverCount: Value(feverCount),
      coughCount: Value(coughCount),
      diarrheaCount: Value(diarrheaCount),
      jaundiceCount: Value(jaundiceCount),
      rashCount: Value(rashCount),
      diseaseType: diseaseType == null && nullToAbsent
          ? const Value.absent()
          : Value(diseaseType),
      maternalRiskFlags: Value(maternalRiskFlags),
      childRiskFlags: Value(childRiskFlags),
      environmentalFlags: Value(environmentalFlags),
      locationLat: locationLat == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLat),
      locationLng: locationLng == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLng),
      photoPaths: Value(photoPaths),
      syncStatus: Value(syncStatus),
    );
  }

  factory ReportsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReportsTableData(
      id: serializer.fromJson<String>(json['id']),
      workerId: serializer.fromJson<String>(json['workerId']),
      workerName: serializer.fromJson<String>(json['workerName']),
      wardCode: serializer.fromJson<String>(json['wardCode']),
      reportDate: serializer.fromJson<DateTime>(json['reportDate']),
      submissionTime: serializer.fromJson<DateTime>(json['submissionTime']),
      feverCount: serializer.fromJson<int>(json['feverCount']),
      coughCount: serializer.fromJson<int>(json['coughCount']),
      diarrheaCount: serializer.fromJson<int>(json['diarrheaCount']),
      jaundiceCount: serializer.fromJson<int>(json['jaundiceCount']),
      rashCount: serializer.fromJson<int>(json['rashCount']),
      diseaseType: serializer.fromJson<String?>(json['diseaseType']),
      maternalRiskFlags: serializer.fromJson<String>(json['maternalRiskFlags']),
      childRiskFlags: serializer.fromJson<String>(json['childRiskFlags']),
      environmentalFlags:
          serializer.fromJson<String>(json['environmentalFlags']),
      locationLat: serializer.fromJson<double?>(json['locationLat']),
      locationLng: serializer.fromJson<double?>(json['locationLng']),
      photoPaths: serializer.fromJson<String>(json['photoPaths']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workerId': serializer.toJson<String>(workerId),
      'workerName': serializer.toJson<String>(workerName),
      'wardCode': serializer.toJson<String>(wardCode),
      'reportDate': serializer.toJson<DateTime>(reportDate),
      'submissionTime': serializer.toJson<DateTime>(submissionTime),
      'feverCount': serializer.toJson<int>(feverCount),
      'coughCount': serializer.toJson<int>(coughCount),
      'diarrheaCount': serializer.toJson<int>(diarrheaCount),
      'jaundiceCount': serializer.toJson<int>(jaundiceCount),
      'rashCount': serializer.toJson<int>(rashCount),
      'diseaseType': serializer.toJson<String?>(diseaseType),
      'maternalRiskFlags': serializer.toJson<String>(maternalRiskFlags),
      'childRiskFlags': serializer.toJson<String>(childRiskFlags),
      'environmentalFlags': serializer.toJson<String>(environmentalFlags),
      'locationLat': serializer.toJson<double?>(locationLat),
      'locationLng': serializer.toJson<double?>(locationLng),
      'photoPaths': serializer.toJson<String>(photoPaths),
      'syncStatus': serializer.toJson<int>(syncStatus),
    };
  }

  ReportsTableData copyWith(
          {String? id,
          String? workerId,
          String? workerName,
          String? wardCode,
          DateTime? reportDate,
          DateTime? submissionTime,
          int? feverCount,
          int? coughCount,
          int? diarrheaCount,
          int? jaundiceCount,
          int? rashCount,
          Value<String?> diseaseType = const Value.absent(),
          String? maternalRiskFlags,
          String? childRiskFlags,
          String? environmentalFlags,
          Value<double?> locationLat = const Value.absent(),
          Value<double?> locationLng = const Value.absent(),
          String? photoPaths,
          int? syncStatus}) =>
      ReportsTableData(
        id: id ?? this.id,
        workerId: workerId ?? this.workerId,
        workerName: workerName ?? this.workerName,
        wardCode: wardCode ?? this.wardCode,
        reportDate: reportDate ?? this.reportDate,
        submissionTime: submissionTime ?? this.submissionTime,
        feverCount: feverCount ?? this.feverCount,
        coughCount: coughCount ?? this.coughCount,
        diarrheaCount: diarrheaCount ?? this.diarrheaCount,
        jaundiceCount: jaundiceCount ?? this.jaundiceCount,
        rashCount: rashCount ?? this.rashCount,
        diseaseType: diseaseType.present ? diseaseType.value : this.diseaseType,
        maternalRiskFlags: maternalRiskFlags ?? this.maternalRiskFlags,
        childRiskFlags: childRiskFlags ?? this.childRiskFlags,
        environmentalFlags: environmentalFlags ?? this.environmentalFlags,
        locationLat: locationLat.present ? locationLat.value : this.locationLat,
        locationLng: locationLng.present ? locationLng.value : this.locationLng,
        photoPaths: photoPaths ?? this.photoPaths,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  ReportsTableData copyWithCompanion(ReportsTableCompanion data) {
    return ReportsTableData(
      id: data.id.present ? data.id.value : this.id,
      workerId: data.workerId.present ? data.workerId.value : this.workerId,
      workerName:
          data.workerName.present ? data.workerName.value : this.workerName,
      wardCode: data.wardCode.present ? data.wardCode.value : this.wardCode,
      reportDate:
          data.reportDate.present ? data.reportDate.value : this.reportDate,
      submissionTime: data.submissionTime.present
          ? data.submissionTime.value
          : this.submissionTime,
      feverCount:
          data.feverCount.present ? data.feverCount.value : this.feverCount,
      coughCount:
          data.coughCount.present ? data.coughCount.value : this.coughCount,
      diarrheaCount: data.diarrheaCount.present
          ? data.diarrheaCount.value
          : this.diarrheaCount,
      jaundiceCount: data.jaundiceCount.present
          ? data.jaundiceCount.value
          : this.jaundiceCount,
      rashCount: data.rashCount.present ? data.rashCount.value : this.rashCount,
      diseaseType:
          data.diseaseType.present ? data.diseaseType.value : this.diseaseType,
      maternalRiskFlags: data.maternalRiskFlags.present
          ? data.maternalRiskFlags.value
          : this.maternalRiskFlags,
      childRiskFlags: data.childRiskFlags.present
          ? data.childRiskFlags.value
          : this.childRiskFlags,
      environmentalFlags: data.environmentalFlags.present
          ? data.environmentalFlags.value
          : this.environmentalFlags,
      locationLat:
          data.locationLat.present ? data.locationLat.value : this.locationLat,
      locationLng:
          data.locationLng.present ? data.locationLng.value : this.locationLng,
      photoPaths:
          data.photoPaths.present ? data.photoPaths.value : this.photoPaths,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReportsTableData(')
          ..write('id: $id, ')
          ..write('workerId: $workerId, ')
          ..write('workerName: $workerName, ')
          ..write('wardCode: $wardCode, ')
          ..write('reportDate: $reportDate, ')
          ..write('submissionTime: $submissionTime, ')
          ..write('feverCount: $feverCount, ')
          ..write('coughCount: $coughCount, ')
          ..write('diarrheaCount: $diarrheaCount, ')
          ..write('jaundiceCount: $jaundiceCount, ')
          ..write('rashCount: $rashCount, ')
          ..write('diseaseType: $diseaseType, ')
          ..write('maternalRiskFlags: $maternalRiskFlags, ')
          ..write('childRiskFlags: $childRiskFlags, ')
          ..write('environmentalFlags: $environmentalFlags, ')
          ..write('locationLat: $locationLat, ')
          ..write('locationLng: $locationLng, ')
          ..write('photoPaths: $photoPaths, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      workerId,
      workerName,
      wardCode,
      reportDate,
      submissionTime,
      feverCount,
      coughCount,
      diarrheaCount,
      jaundiceCount,
      rashCount,
      diseaseType,
      maternalRiskFlags,
      childRiskFlags,
      environmentalFlags,
      locationLat,
      locationLng,
      photoPaths,
      syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReportsTableData &&
          other.id == this.id &&
          other.workerId == this.workerId &&
          other.workerName == this.workerName &&
          other.wardCode == this.wardCode &&
          other.reportDate == this.reportDate &&
          other.submissionTime == this.submissionTime &&
          other.feverCount == this.feverCount &&
          other.coughCount == this.coughCount &&
          other.diarrheaCount == this.diarrheaCount &&
          other.jaundiceCount == this.jaundiceCount &&
          other.rashCount == this.rashCount &&
          other.diseaseType == this.diseaseType &&
          other.maternalRiskFlags == this.maternalRiskFlags &&
          other.childRiskFlags == this.childRiskFlags &&
          other.environmentalFlags == this.environmentalFlags &&
          other.locationLat == this.locationLat &&
          other.locationLng == this.locationLng &&
          other.photoPaths == this.photoPaths &&
          other.syncStatus == this.syncStatus);
}

class ReportsTableCompanion extends UpdateCompanion<ReportsTableData> {
  final Value<String> id;
  final Value<String> workerId;
  final Value<String> workerName;
  final Value<String> wardCode;
  final Value<DateTime> reportDate;
  final Value<DateTime> submissionTime;
  final Value<int> feverCount;
  final Value<int> coughCount;
  final Value<int> diarrheaCount;
  final Value<int> jaundiceCount;
  final Value<int> rashCount;
  final Value<String?> diseaseType;
  final Value<String> maternalRiskFlags;
  final Value<String> childRiskFlags;
  final Value<String> environmentalFlags;
  final Value<double?> locationLat;
  final Value<double?> locationLng;
  final Value<String> photoPaths;
  final Value<int> syncStatus;
  final Value<int> rowid;
  const ReportsTableCompanion({
    this.id = const Value.absent(),
    this.workerId = const Value.absent(),
    this.workerName = const Value.absent(),
    this.wardCode = const Value.absent(),
    this.reportDate = const Value.absent(),
    this.submissionTime = const Value.absent(),
    this.feverCount = const Value.absent(),
    this.coughCount = const Value.absent(),
    this.diarrheaCount = const Value.absent(),
    this.jaundiceCount = const Value.absent(),
    this.rashCount = const Value.absent(),
    this.diseaseType = const Value.absent(),
    this.maternalRiskFlags = const Value.absent(),
    this.childRiskFlags = const Value.absent(),
    this.environmentalFlags = const Value.absent(),
    this.locationLat = const Value.absent(),
    this.locationLng = const Value.absent(),
    this.photoPaths = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReportsTableCompanion.insert({
    required String id,
    required String workerId,
    required String workerName,
    required String wardCode,
    required DateTime reportDate,
    required DateTime submissionTime,
    required int feverCount,
    required int coughCount,
    required int diarrheaCount,
    required int jaundiceCount,
    required int rashCount,
    this.diseaseType = const Value.absent(),
    required String maternalRiskFlags,
    required String childRiskFlags,
    required String environmentalFlags,
    this.locationLat = const Value.absent(),
    this.locationLng = const Value.absent(),
    this.photoPaths = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workerId = Value(workerId),
        workerName = Value(workerName),
        wardCode = Value(wardCode),
        reportDate = Value(reportDate),
        submissionTime = Value(submissionTime),
        feverCount = Value(feverCount),
        coughCount = Value(coughCount),
        diarrheaCount = Value(diarrheaCount),
        jaundiceCount = Value(jaundiceCount),
        rashCount = Value(rashCount),
        maternalRiskFlags = Value(maternalRiskFlags),
        childRiskFlags = Value(childRiskFlags),
        environmentalFlags = Value(environmentalFlags);
  static Insertable<ReportsTableData> custom({
    Expression<String>? id,
    Expression<String>? workerId,
    Expression<String>? workerName,
    Expression<String>? wardCode,
    Expression<DateTime>? reportDate,
    Expression<DateTime>? submissionTime,
    Expression<int>? feverCount,
    Expression<int>? coughCount,
    Expression<int>? diarrheaCount,
    Expression<int>? jaundiceCount,
    Expression<int>? rashCount,
    Expression<String>? diseaseType,
    Expression<String>? maternalRiskFlags,
    Expression<String>? childRiskFlags,
    Expression<String>? environmentalFlags,
    Expression<double>? locationLat,
    Expression<double>? locationLng,
    Expression<String>? photoPaths,
    Expression<int>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workerId != null) 'worker_id': workerId,
      if (workerName != null) 'worker_name': workerName,
      if (wardCode != null) 'ward_code': wardCode,
      if (reportDate != null) 'report_date': reportDate,
      if (submissionTime != null) 'submission_time': submissionTime,
      if (feverCount != null) 'fever_count': feverCount,
      if (coughCount != null) 'cough_count': coughCount,
      if (diarrheaCount != null) 'diarrhea_count': diarrheaCount,
      if (jaundiceCount != null) 'jaundice_count': jaundiceCount,
      if (rashCount != null) 'rash_count': rashCount,
      if (diseaseType != null) 'disease_type': diseaseType,
      if (maternalRiskFlags != null) 'maternal_risk_flags': maternalRiskFlags,
      if (childRiskFlags != null) 'child_risk_flags': childRiskFlags,
      if (environmentalFlags != null) 'environmental_flags': environmentalFlags,
      if (locationLat != null) 'location_lat': locationLat,
      if (locationLng != null) 'location_lng': locationLng,
      if (photoPaths != null) 'photo_paths': photoPaths,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReportsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? workerId,
      Value<String>? workerName,
      Value<String>? wardCode,
      Value<DateTime>? reportDate,
      Value<DateTime>? submissionTime,
      Value<int>? feverCount,
      Value<int>? coughCount,
      Value<int>? diarrheaCount,
      Value<int>? jaundiceCount,
      Value<int>? rashCount,
      Value<String?>? diseaseType,
      Value<String>? maternalRiskFlags,
      Value<String>? childRiskFlags,
      Value<String>? environmentalFlags,
      Value<double?>? locationLat,
      Value<double?>? locationLng,
      Value<String>? photoPaths,
      Value<int>? syncStatus,
      Value<int>? rowid}) {
    return ReportsTableCompanion(
      id: id ?? this.id,
      workerId: workerId ?? this.workerId,
      workerName: workerName ?? this.workerName,
      wardCode: wardCode ?? this.wardCode,
      reportDate: reportDate ?? this.reportDate,
      submissionTime: submissionTime ?? this.submissionTime,
      feverCount: feverCount ?? this.feverCount,
      coughCount: coughCount ?? this.coughCount,
      diarrheaCount: diarrheaCount ?? this.diarrheaCount,
      jaundiceCount: jaundiceCount ?? this.jaundiceCount,
      rashCount: rashCount ?? this.rashCount,
      diseaseType: diseaseType ?? this.diseaseType,
      maternalRiskFlags: maternalRiskFlags ?? this.maternalRiskFlags,
      childRiskFlags: childRiskFlags ?? this.childRiskFlags,
      environmentalFlags: environmentalFlags ?? this.environmentalFlags,
      locationLat: locationLat ?? this.locationLat,
      locationLng: locationLng ?? this.locationLng,
      photoPaths: photoPaths ?? this.photoPaths,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workerId.present) {
      map['worker_id'] = Variable<String>(workerId.value);
    }
    if (workerName.present) {
      map['worker_name'] = Variable<String>(workerName.value);
    }
    if (wardCode.present) {
      map['ward_code'] = Variable<String>(wardCode.value);
    }
    if (reportDate.present) {
      map['report_date'] = Variable<DateTime>(reportDate.value);
    }
    if (submissionTime.present) {
      map['submission_time'] = Variable<DateTime>(submissionTime.value);
    }
    if (feverCount.present) {
      map['fever_count'] = Variable<int>(feverCount.value);
    }
    if (coughCount.present) {
      map['cough_count'] = Variable<int>(coughCount.value);
    }
    if (diarrheaCount.present) {
      map['diarrhea_count'] = Variable<int>(diarrheaCount.value);
    }
    if (jaundiceCount.present) {
      map['jaundice_count'] = Variable<int>(jaundiceCount.value);
    }
    if (rashCount.present) {
      map['rash_count'] = Variable<int>(rashCount.value);
    }
    if (diseaseType.present) {
      map['disease_type'] = Variable<String>(diseaseType.value);
    }
    if (maternalRiskFlags.present) {
      map['maternal_risk_flags'] = Variable<String>(maternalRiskFlags.value);
    }
    if (childRiskFlags.present) {
      map['child_risk_flags'] = Variable<String>(childRiskFlags.value);
    }
    if (environmentalFlags.present) {
      map['environmental_flags'] = Variable<String>(environmentalFlags.value);
    }
    if (locationLat.present) {
      map['location_lat'] = Variable<double>(locationLat.value);
    }
    if (locationLng.present) {
      map['location_lng'] = Variable<double>(locationLng.value);
    }
    if (photoPaths.present) {
      map['photo_paths'] = Variable<String>(photoPaths.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportsTableCompanion(')
          ..write('id: $id, ')
          ..write('workerId: $workerId, ')
          ..write('workerName: $workerName, ')
          ..write('wardCode: $wardCode, ')
          ..write('reportDate: $reportDate, ')
          ..write('submissionTime: $submissionTime, ')
          ..write('feverCount: $feverCount, ')
          ..write('coughCount: $coughCount, ')
          ..write('diarrheaCount: $diarrheaCount, ')
          ..write('jaundiceCount: $jaundiceCount, ')
          ..write('rashCount: $rashCount, ')
          ..write('diseaseType: $diseaseType, ')
          ..write('maternalRiskFlags: $maternalRiskFlags, ')
          ..write('childRiskFlags: $childRiskFlags, ')
          ..write('environmentalFlags: $environmentalFlags, ')
          ..write('locationLat: $locationLat, ')
          ..write('locationLng: $locationLng, ')
          ..write('photoPaths: $photoPaths, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FamiliesTableTable extends FamiliesTable
    with TableInfo<$FamiliesTableTable, FamiliesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FamiliesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _familyNameMeta =
      const VerificationMeta('familyName');
  @override
  late final GeneratedColumn<String> familyName = GeneratedColumn<String>(
      'family_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _headNameMeta =
      const VerificationMeta('headName');
  @override
  late final GeneratedColumn<String> headName = GeneratedColumn<String>(
      'head_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wardCodeMeta =
      const VerificationMeta('wardCode');
  @override
  late final GeneratedColumn<String> wardCode = GeneratedColumn<String>(
      'ward_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contactNumberMeta =
      const VerificationMeta('contactNumber');
  @override
  late final GeneratedColumn<String> contactNumber = GeneratedColumn<String>(
      'contact_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _totalMembersMeta =
      const VerificationMeta('totalMembers');
  @override
  late final GeneratedColumn<int> totalMembers = GeneratedColumn<int>(
      'total_members', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pregnantWomenCountMeta =
      const VerificationMeta('pregnantWomenCount');
  @override
  late final GeneratedColumn<int> pregnantWomenCount = GeneratedColumn<int>(
      'pregnant_women_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _childrenCountMeta =
      const VerificationMeta('childrenCount');
  @override
  late final GeneratedColumn<int> childrenCount = GeneratedColumn<int>(
      'children_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _highRiskFlagMeta =
      const VerificationMeta('highRiskFlag');
  @override
  late final GeneratedColumn<bool> highRiskFlag = GeneratedColumn<bool>(
      'high_risk_flag', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("high_risk_flag" IN (0, 1))'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastVisitMeta =
      const VerificationMeta('lastVisit');
  @override
  late final GeneratedColumn<DateTime> lastVisit = GeneratedColumn<DateTime>(
      'last_visit', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        familyName,
        headName,
        wardCode,
        address,
        contactNumber,
        totalMembers,
        pregnantWomenCount,
        childrenCount,
        highRiskFlag,
        createdAt,
        lastVisit,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'families_table';
  @override
  VerificationContext validateIntegrity(Insertable<FamiliesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('family_name')) {
      context.handle(
          _familyNameMeta,
          familyName.isAcceptableOrUnknown(
              data['family_name']!, _familyNameMeta));
    } else if (isInserting) {
      context.missing(_familyNameMeta);
    }
    if (data.containsKey('head_name')) {
      context.handle(_headNameMeta,
          headName.isAcceptableOrUnknown(data['head_name']!, _headNameMeta));
    } else if (isInserting) {
      context.missing(_headNameMeta);
    }
    if (data.containsKey('ward_code')) {
      context.handle(_wardCodeMeta,
          wardCode.isAcceptableOrUnknown(data['ward_code']!, _wardCodeMeta));
    } else if (isInserting) {
      context.missing(_wardCodeMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('contact_number')) {
      context.handle(
          _contactNumberMeta,
          contactNumber.isAcceptableOrUnknown(
              data['contact_number']!, _contactNumberMeta));
    }
    if (data.containsKey('total_members')) {
      context.handle(
          _totalMembersMeta,
          totalMembers.isAcceptableOrUnknown(
              data['total_members']!, _totalMembersMeta));
    } else if (isInserting) {
      context.missing(_totalMembersMeta);
    }
    if (data.containsKey('pregnant_women_count')) {
      context.handle(
          _pregnantWomenCountMeta,
          pregnantWomenCount.isAcceptableOrUnknown(
              data['pregnant_women_count']!, _pregnantWomenCountMeta));
    } else if (isInserting) {
      context.missing(_pregnantWomenCountMeta);
    }
    if (data.containsKey('children_count')) {
      context.handle(
          _childrenCountMeta,
          childrenCount.isAcceptableOrUnknown(
              data['children_count']!, _childrenCountMeta));
    } else if (isInserting) {
      context.missing(_childrenCountMeta);
    }
    if (data.containsKey('high_risk_flag')) {
      context.handle(
          _highRiskFlagMeta,
          highRiskFlag.isAcceptableOrUnknown(
              data['high_risk_flag']!, _highRiskFlagMeta));
    } else if (isInserting) {
      context.missing(_highRiskFlagMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_visit')) {
      context.handle(_lastVisitMeta,
          lastVisit.isAcceptableOrUnknown(data['last_visit']!, _lastVisitMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FamiliesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FamiliesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      familyName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}family_name'])!,
      headName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}head_name'])!,
      wardCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ward_code'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      contactNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact_number']),
      totalMembers: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_members'])!,
      pregnantWomenCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}pregnant_women_count'])!,
      childrenCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}children_count'])!,
      highRiskFlag: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}high_risk_flag'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      lastVisit: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_visit']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $FamiliesTableTable createAlias(String alias) {
    return $FamiliesTableTable(attachedDatabase, alias);
  }
}

class FamiliesTableData extends DataClass
    implements Insertable<FamiliesTableData> {
  final String id;
  final String familyName;
  final String headName;
  final String wardCode;
  final String address;
  final String? contactNumber;
  final int totalMembers;
  final int pregnantWomenCount;
  final int childrenCount;
  final bool highRiskFlag;
  final DateTime createdAt;
  final DateTime? lastVisit;
  final int syncStatus;
  const FamiliesTableData(
      {required this.id,
      required this.familyName,
      required this.headName,
      required this.wardCode,
      required this.address,
      this.contactNumber,
      required this.totalMembers,
      required this.pregnantWomenCount,
      required this.childrenCount,
      required this.highRiskFlag,
      required this.createdAt,
      this.lastVisit,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['family_name'] = Variable<String>(familyName);
    map['head_name'] = Variable<String>(headName);
    map['ward_code'] = Variable<String>(wardCode);
    map['address'] = Variable<String>(address);
    if (!nullToAbsent || contactNumber != null) {
      map['contact_number'] = Variable<String>(contactNumber);
    }
    map['total_members'] = Variable<int>(totalMembers);
    map['pregnant_women_count'] = Variable<int>(pregnantWomenCount);
    map['children_count'] = Variable<int>(childrenCount);
    map['high_risk_flag'] = Variable<bool>(highRiskFlag);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastVisit != null) {
      map['last_visit'] = Variable<DateTime>(lastVisit);
    }
    map['sync_status'] = Variable<int>(syncStatus);
    return map;
  }

  FamiliesTableCompanion toCompanion(bool nullToAbsent) {
    return FamiliesTableCompanion(
      id: Value(id),
      familyName: Value(familyName),
      headName: Value(headName),
      wardCode: Value(wardCode),
      address: Value(address),
      contactNumber: contactNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(contactNumber),
      totalMembers: Value(totalMembers),
      pregnantWomenCount: Value(pregnantWomenCount),
      childrenCount: Value(childrenCount),
      highRiskFlag: Value(highRiskFlag),
      createdAt: Value(createdAt),
      lastVisit: lastVisit == null && nullToAbsent
          ? const Value.absent()
          : Value(lastVisit),
      syncStatus: Value(syncStatus),
    );
  }

  factory FamiliesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FamiliesTableData(
      id: serializer.fromJson<String>(json['id']),
      familyName: serializer.fromJson<String>(json['familyName']),
      headName: serializer.fromJson<String>(json['headName']),
      wardCode: serializer.fromJson<String>(json['wardCode']),
      address: serializer.fromJson<String>(json['address']),
      contactNumber: serializer.fromJson<String?>(json['contactNumber']),
      totalMembers: serializer.fromJson<int>(json['totalMembers']),
      pregnantWomenCount: serializer.fromJson<int>(json['pregnantWomenCount']),
      childrenCount: serializer.fromJson<int>(json['childrenCount']),
      highRiskFlag: serializer.fromJson<bool>(json['highRiskFlag']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastVisit: serializer.fromJson<DateTime?>(json['lastVisit']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'familyName': serializer.toJson<String>(familyName),
      'headName': serializer.toJson<String>(headName),
      'wardCode': serializer.toJson<String>(wardCode),
      'address': serializer.toJson<String>(address),
      'contactNumber': serializer.toJson<String?>(contactNumber),
      'totalMembers': serializer.toJson<int>(totalMembers),
      'pregnantWomenCount': serializer.toJson<int>(pregnantWomenCount),
      'childrenCount': serializer.toJson<int>(childrenCount),
      'highRiskFlag': serializer.toJson<bool>(highRiskFlag),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastVisit': serializer.toJson<DateTime?>(lastVisit),
      'syncStatus': serializer.toJson<int>(syncStatus),
    };
  }

  FamiliesTableData copyWith(
          {String? id,
          String? familyName,
          String? headName,
          String? wardCode,
          String? address,
          Value<String?> contactNumber = const Value.absent(),
          int? totalMembers,
          int? pregnantWomenCount,
          int? childrenCount,
          bool? highRiskFlag,
          DateTime? createdAt,
          Value<DateTime?> lastVisit = const Value.absent(),
          int? syncStatus}) =>
      FamiliesTableData(
        id: id ?? this.id,
        familyName: familyName ?? this.familyName,
        headName: headName ?? this.headName,
        wardCode: wardCode ?? this.wardCode,
        address: address ?? this.address,
        contactNumber:
            contactNumber.present ? contactNumber.value : this.contactNumber,
        totalMembers: totalMembers ?? this.totalMembers,
        pregnantWomenCount: pregnantWomenCount ?? this.pregnantWomenCount,
        childrenCount: childrenCount ?? this.childrenCount,
        highRiskFlag: highRiskFlag ?? this.highRiskFlag,
        createdAt: createdAt ?? this.createdAt,
        lastVisit: lastVisit.present ? lastVisit.value : this.lastVisit,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  FamiliesTableData copyWithCompanion(FamiliesTableCompanion data) {
    return FamiliesTableData(
      id: data.id.present ? data.id.value : this.id,
      familyName:
          data.familyName.present ? data.familyName.value : this.familyName,
      headName: data.headName.present ? data.headName.value : this.headName,
      wardCode: data.wardCode.present ? data.wardCode.value : this.wardCode,
      address: data.address.present ? data.address.value : this.address,
      contactNumber: data.contactNumber.present
          ? data.contactNumber.value
          : this.contactNumber,
      totalMembers: data.totalMembers.present
          ? data.totalMembers.value
          : this.totalMembers,
      pregnantWomenCount: data.pregnantWomenCount.present
          ? data.pregnantWomenCount.value
          : this.pregnantWomenCount,
      childrenCount: data.childrenCount.present
          ? data.childrenCount.value
          : this.childrenCount,
      highRiskFlag: data.highRiskFlag.present
          ? data.highRiskFlag.value
          : this.highRiskFlag,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastVisit: data.lastVisit.present ? data.lastVisit.value : this.lastVisit,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FamiliesTableData(')
          ..write('id: $id, ')
          ..write('familyName: $familyName, ')
          ..write('headName: $headName, ')
          ..write('wardCode: $wardCode, ')
          ..write('address: $address, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('totalMembers: $totalMembers, ')
          ..write('pregnantWomenCount: $pregnantWomenCount, ')
          ..write('childrenCount: $childrenCount, ')
          ..write('highRiskFlag: $highRiskFlag, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastVisit: $lastVisit, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      familyName,
      headName,
      wardCode,
      address,
      contactNumber,
      totalMembers,
      pregnantWomenCount,
      childrenCount,
      highRiskFlag,
      createdAt,
      lastVisit,
      syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FamiliesTableData &&
          other.id == this.id &&
          other.familyName == this.familyName &&
          other.headName == this.headName &&
          other.wardCode == this.wardCode &&
          other.address == this.address &&
          other.contactNumber == this.contactNumber &&
          other.totalMembers == this.totalMembers &&
          other.pregnantWomenCount == this.pregnantWomenCount &&
          other.childrenCount == this.childrenCount &&
          other.highRiskFlag == this.highRiskFlag &&
          other.createdAt == this.createdAt &&
          other.lastVisit == this.lastVisit &&
          other.syncStatus == this.syncStatus);
}

class FamiliesTableCompanion extends UpdateCompanion<FamiliesTableData> {
  final Value<String> id;
  final Value<String> familyName;
  final Value<String> headName;
  final Value<String> wardCode;
  final Value<String> address;
  final Value<String?> contactNumber;
  final Value<int> totalMembers;
  final Value<int> pregnantWomenCount;
  final Value<int> childrenCount;
  final Value<bool> highRiskFlag;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastVisit;
  final Value<int> syncStatus;
  final Value<int> rowid;
  const FamiliesTableCompanion({
    this.id = const Value.absent(),
    this.familyName = const Value.absent(),
    this.headName = const Value.absent(),
    this.wardCode = const Value.absent(),
    this.address = const Value.absent(),
    this.contactNumber = const Value.absent(),
    this.totalMembers = const Value.absent(),
    this.pregnantWomenCount = const Value.absent(),
    this.childrenCount = const Value.absent(),
    this.highRiskFlag = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastVisit = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FamiliesTableCompanion.insert({
    required String id,
    required String familyName,
    required String headName,
    required String wardCode,
    required String address,
    this.contactNumber = const Value.absent(),
    required int totalMembers,
    required int pregnantWomenCount,
    required int childrenCount,
    required bool highRiskFlag,
    required DateTime createdAt,
    this.lastVisit = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        familyName = Value(familyName),
        headName = Value(headName),
        wardCode = Value(wardCode),
        address = Value(address),
        totalMembers = Value(totalMembers),
        pregnantWomenCount = Value(pregnantWomenCount),
        childrenCount = Value(childrenCount),
        highRiskFlag = Value(highRiskFlag),
        createdAt = Value(createdAt);
  static Insertable<FamiliesTableData> custom({
    Expression<String>? id,
    Expression<String>? familyName,
    Expression<String>? headName,
    Expression<String>? wardCode,
    Expression<String>? address,
    Expression<String>? contactNumber,
    Expression<int>? totalMembers,
    Expression<int>? pregnantWomenCount,
    Expression<int>? childrenCount,
    Expression<bool>? highRiskFlag,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastVisit,
    Expression<int>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (familyName != null) 'family_name': familyName,
      if (headName != null) 'head_name': headName,
      if (wardCode != null) 'ward_code': wardCode,
      if (address != null) 'address': address,
      if (contactNumber != null) 'contact_number': contactNumber,
      if (totalMembers != null) 'total_members': totalMembers,
      if (pregnantWomenCount != null)
        'pregnant_women_count': pregnantWomenCount,
      if (childrenCount != null) 'children_count': childrenCount,
      if (highRiskFlag != null) 'high_risk_flag': highRiskFlag,
      if (createdAt != null) 'created_at': createdAt,
      if (lastVisit != null) 'last_visit': lastVisit,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FamiliesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? familyName,
      Value<String>? headName,
      Value<String>? wardCode,
      Value<String>? address,
      Value<String?>? contactNumber,
      Value<int>? totalMembers,
      Value<int>? pregnantWomenCount,
      Value<int>? childrenCount,
      Value<bool>? highRiskFlag,
      Value<DateTime>? createdAt,
      Value<DateTime?>? lastVisit,
      Value<int>? syncStatus,
      Value<int>? rowid}) {
    return FamiliesTableCompanion(
      id: id ?? this.id,
      familyName: familyName ?? this.familyName,
      headName: headName ?? this.headName,
      wardCode: wardCode ?? this.wardCode,
      address: address ?? this.address,
      contactNumber: contactNumber ?? this.contactNumber,
      totalMembers: totalMembers ?? this.totalMembers,
      pregnantWomenCount: pregnantWomenCount ?? this.pregnantWomenCount,
      childrenCount: childrenCount ?? this.childrenCount,
      highRiskFlag: highRiskFlag ?? this.highRiskFlag,
      createdAt: createdAt ?? this.createdAt,
      lastVisit: lastVisit ?? this.lastVisit,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (familyName.present) {
      map['family_name'] = Variable<String>(familyName.value);
    }
    if (headName.present) {
      map['head_name'] = Variable<String>(headName.value);
    }
    if (wardCode.present) {
      map['ward_code'] = Variable<String>(wardCode.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (contactNumber.present) {
      map['contact_number'] = Variable<String>(contactNumber.value);
    }
    if (totalMembers.present) {
      map['total_members'] = Variable<int>(totalMembers.value);
    }
    if (pregnantWomenCount.present) {
      map['pregnant_women_count'] = Variable<int>(pregnantWomenCount.value);
    }
    if (childrenCount.present) {
      map['children_count'] = Variable<int>(childrenCount.value);
    }
    if (highRiskFlag.present) {
      map['high_risk_flag'] = Variable<bool>(highRiskFlag.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastVisit.present) {
      map['last_visit'] = Variable<DateTime>(lastVisit.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FamiliesTableCompanion(')
          ..write('id: $id, ')
          ..write('familyName: $familyName, ')
          ..write('headName: $headName, ')
          ..write('wardCode: $wardCode, ')
          ..write('address: $address, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('totalMembers: $totalMembers, ')
          ..write('pregnantWomenCount: $pregnantWomenCount, ')
          ..write('childrenCount: $childrenCount, ')
          ..write('highRiskFlag: $highRiskFlag, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastVisit: $lastVisit, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChildrenTableTable extends ChildrenTable
    with TableInfo<$ChildrenTableTable, ChildrenTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChildrenTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _familyIdMeta =
      const VerificationMeta('familyId');
  @override
  late final GeneratedColumn<String> familyId = GeneratedColumn<String>(
      'family_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
      'date_of_birth', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bloodGroupMeta =
      const VerificationMeta('bloodGroup');
  @override
  late final GeneratedColumn<String> bloodGroup = GeneratedColumn<String>(
      'blood_group', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nutritionStatusMeta =
      const VerificationMeta('nutritionStatus');
  @override
  late final GeneratedColumn<String> nutritionStatus = GeneratedColumn<String>(
      'nutrition_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('normal'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        familyId,
        name,
        dateOfBirth,
        gender,
        bloodGroup,
        nutritionStatus,
        createdAt,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'children_table';
  @override
  VerificationContext validateIntegrity(Insertable<ChildrenTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('family_id')) {
      context.handle(_familyIdMeta,
          familyId.isAcceptableOrUnknown(data['family_id']!, _familyIdMeta));
    } else if (isInserting) {
      context.missing(_familyIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    } else if (isInserting) {
      context.missing(_dateOfBirthMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('blood_group')) {
      context.handle(
          _bloodGroupMeta,
          bloodGroup.isAcceptableOrUnknown(
              data['blood_group']!, _bloodGroupMeta));
    }
    if (data.containsKey('nutrition_status')) {
      context.handle(
          _nutritionStatusMeta,
          nutritionStatus.isAcceptableOrUnknown(
              data['nutrition_status']!, _nutritionStatusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChildrenTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChildrenTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      familyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}family_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      dateOfBirth: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_of_birth'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      bloodGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}blood_group']),
      nutritionStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}nutrition_status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $ChildrenTableTable createAlias(String alias) {
    return $ChildrenTableTable(attachedDatabase, alias);
  }
}

class ChildrenTableData extends DataClass
    implements Insertable<ChildrenTableData> {
  final String id;
  final String familyId;
  final String name;
  final DateTime dateOfBirth;
  final String gender;
  final String? bloodGroup;
  final String nutritionStatus;
  final DateTime createdAt;
  final int syncStatus;
  const ChildrenTableData(
      {required this.id,
      required this.familyId,
      required this.name,
      required this.dateOfBirth,
      required this.gender,
      this.bloodGroup,
      required this.nutritionStatus,
      required this.createdAt,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['family_id'] = Variable<String>(familyId);
    map['name'] = Variable<String>(name);
    map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    map['gender'] = Variable<String>(gender);
    if (!nullToAbsent || bloodGroup != null) {
      map['blood_group'] = Variable<String>(bloodGroup);
    }
    map['nutrition_status'] = Variable<String>(nutritionStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sync_status'] = Variable<int>(syncStatus);
    return map;
  }

  ChildrenTableCompanion toCompanion(bool nullToAbsent) {
    return ChildrenTableCompanion(
      id: Value(id),
      familyId: Value(familyId),
      name: Value(name),
      dateOfBirth: Value(dateOfBirth),
      gender: Value(gender),
      bloodGroup: bloodGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodGroup),
      nutritionStatus: Value(nutritionStatus),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory ChildrenTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChildrenTableData(
      id: serializer.fromJson<String>(json['id']),
      familyId: serializer.fromJson<String>(json['familyId']),
      name: serializer.fromJson<String>(json['name']),
      dateOfBirth: serializer.fromJson<DateTime>(json['dateOfBirth']),
      gender: serializer.fromJson<String>(json['gender']),
      bloodGroup: serializer.fromJson<String?>(json['bloodGroup']),
      nutritionStatus: serializer.fromJson<String>(json['nutritionStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'familyId': serializer.toJson<String>(familyId),
      'name': serializer.toJson<String>(name),
      'dateOfBirth': serializer.toJson<DateTime>(dateOfBirth),
      'gender': serializer.toJson<String>(gender),
      'bloodGroup': serializer.toJson<String?>(bloodGroup),
      'nutritionStatus': serializer.toJson<String>(nutritionStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<int>(syncStatus),
    };
  }

  ChildrenTableData copyWith(
          {String? id,
          String? familyId,
          String? name,
          DateTime? dateOfBirth,
          String? gender,
          Value<String?> bloodGroup = const Value.absent(),
          String? nutritionStatus,
          DateTime? createdAt,
          int? syncStatus}) =>
      ChildrenTableData(
        id: id ?? this.id,
        familyId: familyId ?? this.familyId,
        name: name ?? this.name,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        gender: gender ?? this.gender,
        bloodGroup: bloodGroup.present ? bloodGroup.value : this.bloodGroup,
        nutritionStatus: nutritionStatus ?? this.nutritionStatus,
        createdAt: createdAt ?? this.createdAt,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  ChildrenTableData copyWithCompanion(ChildrenTableCompanion data) {
    return ChildrenTableData(
      id: data.id.present ? data.id.value : this.id,
      familyId: data.familyId.present ? data.familyId.value : this.familyId,
      name: data.name.present ? data.name.value : this.name,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
      gender: data.gender.present ? data.gender.value : this.gender,
      bloodGroup:
          data.bloodGroup.present ? data.bloodGroup.value : this.bloodGroup,
      nutritionStatus: data.nutritionStatus.present
          ? data.nutritionStatus.value
          : this.nutritionStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChildrenTableData(')
          ..write('id: $id, ')
          ..write('familyId: $familyId, ')
          ..write('name: $name, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('gender: $gender, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('nutritionStatus: $nutritionStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, familyId, name, dateOfBirth, gender,
      bloodGroup, nutritionStatus, createdAt, syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChildrenTableData &&
          other.id == this.id &&
          other.familyId == this.familyId &&
          other.name == this.name &&
          other.dateOfBirth == this.dateOfBirth &&
          other.gender == this.gender &&
          other.bloodGroup == this.bloodGroup &&
          other.nutritionStatus == this.nutritionStatus &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus);
}

class ChildrenTableCompanion extends UpdateCompanion<ChildrenTableData> {
  final Value<String> id;
  final Value<String> familyId;
  final Value<String> name;
  final Value<DateTime> dateOfBirth;
  final Value<String> gender;
  final Value<String?> bloodGroup;
  final Value<String> nutritionStatus;
  final Value<DateTime> createdAt;
  final Value<int> syncStatus;
  final Value<int> rowid;
  const ChildrenTableCompanion({
    this.id = const Value.absent(),
    this.familyId = const Value.absent(),
    this.name = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.gender = const Value.absent(),
    this.bloodGroup = const Value.absent(),
    this.nutritionStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChildrenTableCompanion.insert({
    required String id,
    required String familyId,
    required String name,
    required DateTime dateOfBirth,
    required String gender,
    this.bloodGroup = const Value.absent(),
    this.nutritionStatus = const Value.absent(),
    required DateTime createdAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        familyId = Value(familyId),
        name = Value(name),
        dateOfBirth = Value(dateOfBirth),
        gender = Value(gender),
        createdAt = Value(createdAt);
  static Insertable<ChildrenTableData> custom({
    Expression<String>? id,
    Expression<String>? familyId,
    Expression<String>? name,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? gender,
    Expression<String>? bloodGroup,
    Expression<String>? nutritionStatus,
    Expression<DateTime>? createdAt,
    Expression<int>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (familyId != null) 'family_id': familyId,
      if (name != null) 'name': name,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (gender != null) 'gender': gender,
      if (bloodGroup != null) 'blood_group': bloodGroup,
      if (nutritionStatus != null) 'nutrition_status': nutritionStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChildrenTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? familyId,
      Value<String>? name,
      Value<DateTime>? dateOfBirth,
      Value<String>? gender,
      Value<String?>? bloodGroup,
      Value<String>? nutritionStatus,
      Value<DateTime>? createdAt,
      Value<int>? syncStatus,
      Value<int>? rowid}) {
    return ChildrenTableCompanion(
      id: id ?? this.id,
      familyId: familyId ?? this.familyId,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      nutritionStatus: nutritionStatus ?? this.nutritionStatus,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (familyId.present) {
      map['family_id'] = Variable<String>(familyId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (bloodGroup.present) {
      map['blood_group'] = Variable<String>(bloodGroup.value);
    }
    if (nutritionStatus.present) {
      map['nutrition_status'] = Variable<String>(nutritionStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChildrenTableCompanion(')
          ..write('id: $id, ')
          ..write('familyId: $familyId, ')
          ..write('name: $name, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('gender: $gender, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('nutritionStatus: $nutritionStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GrowthMeasurementsTableTable extends GrowthMeasurementsTable
    with TableInfo<$GrowthMeasurementsTableTable, GrowthMeasurementsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrowthMeasurementsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
      'child_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _measuredAtMeta =
      const VerificationMeta('measuredAt');
  @override
  late final GeneratedColumn<DateTime> measuredAt = GeneratedColumn<DateTime>(
      'measured_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _heightCmMeta =
      const VerificationMeta('heightCm');
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
      'height_cm', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _ageMonthsMeta =
      const VerificationMeta('ageMonths');
  @override
  late final GeneratedColumn<int> ageMonths = GeneratedColumn<int>(
      'age_months', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nutritionStatusMeta =
      const VerificationMeta('nutritionStatus');
  @override
  late final GeneratedColumn<String> nutritionStatus = GeneratedColumn<String>(
      'nutrition_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        measuredAt,
        weightKg,
        heightCm,
        ageMonths,
        nutritionStatus,
        notes,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'growth_measurements_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<GrowthMeasurementsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('measured_at')) {
      context.handle(
          _measuredAtMeta,
          measuredAt.isAcceptableOrUnknown(
              data['measured_at']!, _measuredAtMeta));
    } else if (isInserting) {
      context.missing(_measuredAtMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(_heightCmMeta,
          heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta));
    } else if (isInserting) {
      context.missing(_heightCmMeta);
    }
    if (data.containsKey('age_months')) {
      context.handle(_ageMonthsMeta,
          ageMonths.isAcceptableOrUnknown(data['age_months']!, _ageMonthsMeta));
    } else if (isInserting) {
      context.missing(_ageMonthsMeta);
    }
    if (data.containsKey('nutrition_status')) {
      context.handle(
          _nutritionStatusMeta,
          nutritionStatus.isAcceptableOrUnknown(
              data['nutrition_status']!, _nutritionStatusMeta));
    } else if (isInserting) {
      context.missing(_nutritionStatusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GrowthMeasurementsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrowthMeasurementsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}child_id'])!,
      measuredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}measured_at'])!,
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg'])!,
      heightCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height_cm'])!,
      ageMonths: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age_months'])!,
      nutritionStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}nutrition_status'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $GrowthMeasurementsTableTable createAlias(String alias) {
    return $GrowthMeasurementsTableTable(attachedDatabase, alias);
  }
}

class GrowthMeasurementsTableData extends DataClass
    implements Insertable<GrowthMeasurementsTableData> {
  final int id;
  final String childId;
  final DateTime measuredAt;
  final double weightKg;
  final double heightCm;
  final int ageMonths;
  final String nutritionStatus;
  final String? notes;
  final int syncStatus;
  const GrowthMeasurementsTableData(
      {required this.id,
      required this.childId,
      required this.measuredAt,
      required this.weightKg,
      required this.heightCm,
      required this.ageMonths,
      required this.nutritionStatus,
      this.notes,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['child_id'] = Variable<String>(childId);
    map['measured_at'] = Variable<DateTime>(measuredAt);
    map['weight_kg'] = Variable<double>(weightKg);
    map['height_cm'] = Variable<double>(heightCm);
    map['age_months'] = Variable<int>(ageMonths);
    map['nutrition_status'] = Variable<String>(nutritionStatus);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['sync_status'] = Variable<int>(syncStatus);
    return map;
  }

  GrowthMeasurementsTableCompanion toCompanion(bool nullToAbsent) {
    return GrowthMeasurementsTableCompanion(
      id: Value(id),
      childId: Value(childId),
      measuredAt: Value(measuredAt),
      weightKg: Value(weightKg),
      heightCm: Value(heightCm),
      ageMonths: Value(ageMonths),
      nutritionStatus: Value(nutritionStatus),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      syncStatus: Value(syncStatus),
    );
  }

  factory GrowthMeasurementsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrowthMeasurementsTableData(
      id: serializer.fromJson<int>(json['id']),
      childId: serializer.fromJson<String>(json['childId']),
      measuredAt: serializer.fromJson<DateTime>(json['measuredAt']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      heightCm: serializer.fromJson<double>(json['heightCm']),
      ageMonths: serializer.fromJson<int>(json['ageMonths']),
      nutritionStatus: serializer.fromJson<String>(json['nutritionStatus']),
      notes: serializer.fromJson<String?>(json['notes']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'childId': serializer.toJson<String>(childId),
      'measuredAt': serializer.toJson<DateTime>(measuredAt),
      'weightKg': serializer.toJson<double>(weightKg),
      'heightCm': serializer.toJson<double>(heightCm),
      'ageMonths': serializer.toJson<int>(ageMonths),
      'nutritionStatus': serializer.toJson<String>(nutritionStatus),
      'notes': serializer.toJson<String?>(notes),
      'syncStatus': serializer.toJson<int>(syncStatus),
    };
  }

  GrowthMeasurementsTableData copyWith(
          {int? id,
          String? childId,
          DateTime? measuredAt,
          double? weightKg,
          double? heightCm,
          int? ageMonths,
          String? nutritionStatus,
          Value<String?> notes = const Value.absent(),
          int? syncStatus}) =>
      GrowthMeasurementsTableData(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        measuredAt: measuredAt ?? this.measuredAt,
        weightKg: weightKg ?? this.weightKg,
        heightCm: heightCm ?? this.heightCm,
        ageMonths: ageMonths ?? this.ageMonths,
        nutritionStatus: nutritionStatus ?? this.nutritionStatus,
        notes: notes.present ? notes.value : this.notes,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  GrowthMeasurementsTableData copyWithCompanion(
      GrowthMeasurementsTableCompanion data) {
    return GrowthMeasurementsTableData(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      measuredAt:
          data.measuredAt.present ? data.measuredAt.value : this.measuredAt,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      ageMonths: data.ageMonths.present ? data.ageMonths.value : this.ageMonths,
      nutritionStatus: data.nutritionStatus.present
          ? data.nutritionStatus.value
          : this.nutritionStatus,
      notes: data.notes.present ? data.notes.value : this.notes,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrowthMeasurementsTableData(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('weightKg: $weightKg, ')
          ..write('heightCm: $heightCm, ')
          ..write('ageMonths: $ageMonths, ')
          ..write('nutritionStatus: $nutritionStatus, ')
          ..write('notes: $notes, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, childId, measuredAt, weightKg, heightCm,
      ageMonths, nutritionStatus, notes, syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrowthMeasurementsTableData &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.measuredAt == this.measuredAt &&
          other.weightKg == this.weightKg &&
          other.heightCm == this.heightCm &&
          other.ageMonths == this.ageMonths &&
          other.nutritionStatus == this.nutritionStatus &&
          other.notes == this.notes &&
          other.syncStatus == this.syncStatus);
}

class GrowthMeasurementsTableCompanion
    extends UpdateCompanion<GrowthMeasurementsTableData> {
  final Value<int> id;
  final Value<String> childId;
  final Value<DateTime> measuredAt;
  final Value<double> weightKg;
  final Value<double> heightCm;
  final Value<int> ageMonths;
  final Value<String> nutritionStatus;
  final Value<String?> notes;
  final Value<int> syncStatus;
  const GrowthMeasurementsTableCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.measuredAt = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.ageMonths = const Value.absent(),
    this.nutritionStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.syncStatus = const Value.absent(),
  });
  GrowthMeasurementsTableCompanion.insert({
    this.id = const Value.absent(),
    required String childId,
    required DateTime measuredAt,
    required double weightKg,
    required double heightCm,
    required int ageMonths,
    required String nutritionStatus,
    this.notes = const Value.absent(),
    this.syncStatus = const Value.absent(),
  })  : childId = Value(childId),
        measuredAt = Value(measuredAt),
        weightKg = Value(weightKg),
        heightCm = Value(heightCm),
        ageMonths = Value(ageMonths),
        nutritionStatus = Value(nutritionStatus);
  static Insertable<GrowthMeasurementsTableData> custom({
    Expression<int>? id,
    Expression<String>? childId,
    Expression<DateTime>? measuredAt,
    Expression<double>? weightKg,
    Expression<double>? heightCm,
    Expression<int>? ageMonths,
    Expression<String>? nutritionStatus,
    Expression<String>? notes,
    Expression<int>? syncStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (measuredAt != null) 'measured_at': measuredAt,
      if (weightKg != null) 'weight_kg': weightKg,
      if (heightCm != null) 'height_cm': heightCm,
      if (ageMonths != null) 'age_months': ageMonths,
      if (nutritionStatus != null) 'nutrition_status': nutritionStatus,
      if (notes != null) 'notes': notes,
      if (syncStatus != null) 'sync_status': syncStatus,
    });
  }

  GrowthMeasurementsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? childId,
      Value<DateTime>? measuredAt,
      Value<double>? weightKg,
      Value<double>? heightCm,
      Value<int>? ageMonths,
      Value<String>? nutritionStatus,
      Value<String?>? notes,
      Value<int>? syncStatus}) {
    return GrowthMeasurementsTableCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      measuredAt: measuredAt ?? this.measuredAt,
      weightKg: weightKg ?? this.weightKg,
      heightCm: heightCm ?? this.heightCm,
      ageMonths: ageMonths ?? this.ageMonths,
      nutritionStatus: nutritionStatus ?? this.nutritionStatus,
      notes: notes ?? this.notes,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (measuredAt.present) {
      map['measured_at'] = Variable<DateTime>(measuredAt.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (ageMonths.present) {
      map['age_months'] = Variable<int>(ageMonths.value);
    }
    if (nutritionStatus.present) {
      map['nutrition_status'] = Variable<String>(nutritionStatus.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrowthMeasurementsTableCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('weightKg: $weightKg, ')
          ..write('heightCm: $heightCm, ')
          ..write('ageMonths: $ageMonths, ')
          ..write('nutritionStatus: $nutritionStatus, ')
          ..write('notes: $notes, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }
}

class $VaccinationsTableTable extends VaccinationsTable
    with TableInfo<$VaccinationsTableTable, VaccinationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VaccinationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
      'child_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _vaccineNameMeta =
      const VerificationMeta('vaccineName');
  @override
  late final GeneratedColumn<String> vaccineName = GeneratedColumn<String>(
      'vaccine_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _doseNumberMeta =
      const VerificationMeta('doseNumber');
  @override
  late final GeneratedColumn<int> doseNumber = GeneratedColumn<int>(
      'dose_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateGivenMeta =
      const VerificationMeta('dateGiven');
  @override
  late final GeneratedColumn<DateTime> dateGiven = GeneratedColumn<DateTime>(
      'date_given', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _nextDueDateMeta =
      const VerificationMeta('nextDueDate');
  @override
  late final GeneratedColumn<DateTime> nextDueDate = GeneratedColumn<DateTime>(
      'next_due_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _remarksMeta =
      const VerificationMeta('remarks');
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
      'remarks', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        vaccineName,
        doseNumber,
        dateGiven,
        nextDueDate,
        remarks,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vaccinations_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<VaccinationsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('vaccine_name')) {
      context.handle(
          _vaccineNameMeta,
          vaccineName.isAcceptableOrUnknown(
              data['vaccine_name']!, _vaccineNameMeta));
    } else if (isInserting) {
      context.missing(_vaccineNameMeta);
    }
    if (data.containsKey('dose_number')) {
      context.handle(
          _doseNumberMeta,
          doseNumber.isAcceptableOrUnknown(
              data['dose_number']!, _doseNumberMeta));
    } else if (isInserting) {
      context.missing(_doseNumberMeta);
    }
    if (data.containsKey('date_given')) {
      context.handle(_dateGivenMeta,
          dateGiven.isAcceptableOrUnknown(data['date_given']!, _dateGivenMeta));
    } else if (isInserting) {
      context.missing(_dateGivenMeta);
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
          _nextDueDateMeta,
          nextDueDate.isAcceptableOrUnknown(
              data['next_due_date']!, _nextDueDateMeta));
    }
    if (data.containsKey('remarks')) {
      context.handle(_remarksMeta,
          remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VaccinationsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VaccinationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}child_id'])!,
      vaccineName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vaccine_name'])!,
      doseNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dose_number'])!,
      dateGiven: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_given'])!,
      nextDueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}next_due_date']),
      remarks: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remarks']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $VaccinationsTableTable createAlias(String alias) {
    return $VaccinationsTableTable(attachedDatabase, alias);
  }
}

class VaccinationsTableData extends DataClass
    implements Insertable<VaccinationsTableData> {
  final int id;
  final String childId;
  final String vaccineName;
  final int doseNumber;
  final DateTime dateGiven;
  final DateTime? nextDueDate;
  final String? remarks;
  final int syncStatus;
  const VaccinationsTableData(
      {required this.id,
      required this.childId,
      required this.vaccineName,
      required this.doseNumber,
      required this.dateGiven,
      this.nextDueDate,
      this.remarks,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['child_id'] = Variable<String>(childId);
    map['vaccine_name'] = Variable<String>(vaccineName);
    map['dose_number'] = Variable<int>(doseNumber);
    map['date_given'] = Variable<DateTime>(dateGiven);
    if (!nullToAbsent || nextDueDate != null) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate);
    }
    if (!nullToAbsent || remarks != null) {
      map['remarks'] = Variable<String>(remarks);
    }
    map['sync_status'] = Variable<int>(syncStatus);
    return map;
  }

  VaccinationsTableCompanion toCompanion(bool nullToAbsent) {
    return VaccinationsTableCompanion(
      id: Value(id),
      childId: Value(childId),
      vaccineName: Value(vaccineName),
      doseNumber: Value(doseNumber),
      dateGiven: Value(dateGiven),
      nextDueDate: nextDueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueDate),
      remarks: remarks == null && nullToAbsent
          ? const Value.absent()
          : Value(remarks),
      syncStatus: Value(syncStatus),
    );
  }

  factory VaccinationsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VaccinationsTableData(
      id: serializer.fromJson<int>(json['id']),
      childId: serializer.fromJson<String>(json['childId']),
      vaccineName: serializer.fromJson<String>(json['vaccineName']),
      doseNumber: serializer.fromJson<int>(json['doseNumber']),
      dateGiven: serializer.fromJson<DateTime>(json['dateGiven']),
      nextDueDate: serializer.fromJson<DateTime?>(json['nextDueDate']),
      remarks: serializer.fromJson<String?>(json['remarks']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'childId': serializer.toJson<String>(childId),
      'vaccineName': serializer.toJson<String>(vaccineName),
      'doseNumber': serializer.toJson<int>(doseNumber),
      'dateGiven': serializer.toJson<DateTime>(dateGiven),
      'nextDueDate': serializer.toJson<DateTime?>(nextDueDate),
      'remarks': serializer.toJson<String?>(remarks),
      'syncStatus': serializer.toJson<int>(syncStatus),
    };
  }

  VaccinationsTableData copyWith(
          {int? id,
          String? childId,
          String? vaccineName,
          int? doseNumber,
          DateTime? dateGiven,
          Value<DateTime?> nextDueDate = const Value.absent(),
          Value<String?> remarks = const Value.absent(),
          int? syncStatus}) =>
      VaccinationsTableData(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        vaccineName: vaccineName ?? this.vaccineName,
        doseNumber: doseNumber ?? this.doseNumber,
        dateGiven: dateGiven ?? this.dateGiven,
        nextDueDate: nextDueDate.present ? nextDueDate.value : this.nextDueDate,
        remarks: remarks.present ? remarks.value : this.remarks,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  VaccinationsTableData copyWithCompanion(VaccinationsTableCompanion data) {
    return VaccinationsTableData(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      vaccineName:
          data.vaccineName.present ? data.vaccineName.value : this.vaccineName,
      doseNumber:
          data.doseNumber.present ? data.doseNumber.value : this.doseNumber,
      dateGiven: data.dateGiven.present ? data.dateGiven.value : this.dateGiven,
      nextDueDate:
          data.nextDueDate.present ? data.nextDueDate.value : this.nextDueDate,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VaccinationsTableData(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('vaccineName: $vaccineName, ')
          ..write('doseNumber: $doseNumber, ')
          ..write('dateGiven: $dateGiven, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('remarks: $remarks, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, childId, vaccineName, doseNumber,
      dateGiven, nextDueDate, remarks, syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VaccinationsTableData &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.vaccineName == this.vaccineName &&
          other.doseNumber == this.doseNumber &&
          other.dateGiven == this.dateGiven &&
          other.nextDueDate == this.nextDueDate &&
          other.remarks == this.remarks &&
          other.syncStatus == this.syncStatus);
}

class VaccinationsTableCompanion
    extends UpdateCompanion<VaccinationsTableData> {
  final Value<int> id;
  final Value<String> childId;
  final Value<String> vaccineName;
  final Value<int> doseNumber;
  final Value<DateTime> dateGiven;
  final Value<DateTime?> nextDueDate;
  final Value<String?> remarks;
  final Value<int> syncStatus;
  const VaccinationsTableCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.vaccineName = const Value.absent(),
    this.doseNumber = const Value.absent(),
    this.dateGiven = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.remarks = const Value.absent(),
    this.syncStatus = const Value.absent(),
  });
  VaccinationsTableCompanion.insert({
    this.id = const Value.absent(),
    required String childId,
    required String vaccineName,
    required int doseNumber,
    required DateTime dateGiven,
    this.nextDueDate = const Value.absent(),
    this.remarks = const Value.absent(),
    this.syncStatus = const Value.absent(),
  })  : childId = Value(childId),
        vaccineName = Value(vaccineName),
        doseNumber = Value(doseNumber),
        dateGiven = Value(dateGiven);
  static Insertable<VaccinationsTableData> custom({
    Expression<int>? id,
    Expression<String>? childId,
    Expression<String>? vaccineName,
    Expression<int>? doseNumber,
    Expression<DateTime>? dateGiven,
    Expression<DateTime>? nextDueDate,
    Expression<String>? remarks,
    Expression<int>? syncStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (vaccineName != null) 'vaccine_name': vaccineName,
      if (doseNumber != null) 'dose_number': doseNumber,
      if (dateGiven != null) 'date_given': dateGiven,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
      if (remarks != null) 'remarks': remarks,
      if (syncStatus != null) 'sync_status': syncStatus,
    });
  }

  VaccinationsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? childId,
      Value<String>? vaccineName,
      Value<int>? doseNumber,
      Value<DateTime>? dateGiven,
      Value<DateTime?>? nextDueDate,
      Value<String?>? remarks,
      Value<int>? syncStatus}) {
    return VaccinationsTableCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      vaccineName: vaccineName ?? this.vaccineName,
      doseNumber: doseNumber ?? this.doseNumber,
      dateGiven: dateGiven ?? this.dateGiven,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      remarks: remarks ?? this.remarks,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (vaccineName.present) {
      map['vaccine_name'] = Variable<String>(vaccineName.value);
    }
    if (doseNumber.present) {
      map['dose_number'] = Variable<int>(doseNumber.value);
    }
    if (dateGiven.present) {
      map['date_given'] = Variable<DateTime>(dateGiven.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VaccinationsTableCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('vaccineName: $vaccineName, ')
          ..write('doseNumber: $doseNumber, ')
          ..write('dateGiven: $dateGiven, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('remarks: $remarks, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }
}

class $VisitsTableTable extends VisitsTable
    with TableInfo<$VisitsTableTable, VisitsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VisitsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _familyIdMeta =
      const VerificationMeta('familyId');
  @override
  late final GeneratedColumn<String> familyId = GeneratedColumn<String>(
      'family_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _visitDateMeta =
      const VerificationMeta('visitDate');
  @override
  late final GeneratedColumn<DateTime> visitDate = GeneratedColumn<DateTime>(
      'visit_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _healthStatusMeta =
      const VerificationMeta('healthStatus');
  @override
  late final GeneratedColumn<String> healthStatus = GeneratedColumn<String>(
      'health_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _feverMeta = const VerificationMeta('fever');
  @override
  late final GeneratedColumn<bool> fever = GeneratedColumn<bool>(
      'fever', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("fever" IN (0, 1))'));
  static const VerificationMeta _coughMeta = const VerificationMeta('cough');
  @override
  late final GeneratedColumn<bool> cough = GeneratedColumn<bool>(
      'cough', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("cough" IN (0, 1))'));
  static const VerificationMeta _diarrheaMeta =
      const VerificationMeta('diarrhea');
  @override
  late final GeneratedColumn<bool> diarrhea = GeneratedColumn<bool>(
      'diarrhea', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("diarrhea" IN (0, 1))'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _followUpRequiredMeta =
      const VerificationMeta('followUpRequired');
  @override
  late final GeneratedColumn<bool> followUpRequired = GeneratedColumn<bool>(
      'follow_up_required', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("follow_up_required" IN (0, 1))'));
  static const VerificationMeta _locationLatMeta =
      const VerificationMeta('locationLat');
  @override
  late final GeneratedColumn<double> locationLat = GeneratedColumn<double>(
      'location_lat', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _locationLngMeta =
      const VerificationMeta('locationLng');
  @override
  late final GeneratedColumn<double> locationLng = GeneratedColumn<double>(
      'location_lng', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        familyId,
        visitDate,
        healthStatus,
        fever,
        cough,
        diarrhea,
        notes,
        followUpRequired,
        locationLat,
        locationLng,
        photoPath,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'visits_table';
  @override
  VerificationContext validateIntegrity(Insertable<VisitsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('family_id')) {
      context.handle(_familyIdMeta,
          familyId.isAcceptableOrUnknown(data['family_id']!, _familyIdMeta));
    } else if (isInserting) {
      context.missing(_familyIdMeta);
    }
    if (data.containsKey('visit_date')) {
      context.handle(_visitDateMeta,
          visitDate.isAcceptableOrUnknown(data['visit_date']!, _visitDateMeta));
    } else if (isInserting) {
      context.missing(_visitDateMeta);
    }
    if (data.containsKey('health_status')) {
      context.handle(
          _healthStatusMeta,
          healthStatus.isAcceptableOrUnknown(
              data['health_status']!, _healthStatusMeta));
    } else if (isInserting) {
      context.missing(_healthStatusMeta);
    }
    if (data.containsKey('fever')) {
      context.handle(
          _feverMeta, fever.isAcceptableOrUnknown(data['fever']!, _feverMeta));
    } else if (isInserting) {
      context.missing(_feverMeta);
    }
    if (data.containsKey('cough')) {
      context.handle(
          _coughMeta, cough.isAcceptableOrUnknown(data['cough']!, _coughMeta));
    } else if (isInserting) {
      context.missing(_coughMeta);
    }
    if (data.containsKey('diarrhea')) {
      context.handle(_diarrheaMeta,
          diarrhea.isAcceptableOrUnknown(data['diarrhea']!, _diarrheaMeta));
    } else if (isInserting) {
      context.missing(_diarrheaMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('follow_up_required')) {
      context.handle(
          _followUpRequiredMeta,
          followUpRequired.isAcceptableOrUnknown(
              data['follow_up_required']!, _followUpRequiredMeta));
    } else if (isInserting) {
      context.missing(_followUpRequiredMeta);
    }
    if (data.containsKey('location_lat')) {
      context.handle(
          _locationLatMeta,
          locationLat.isAcceptableOrUnknown(
              data['location_lat']!, _locationLatMeta));
    }
    if (data.containsKey('location_lng')) {
      context.handle(
          _locationLngMeta,
          locationLng.isAcceptableOrUnknown(
              data['location_lng']!, _locationLngMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VisitsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VisitsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      familyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}family_id'])!,
      visitDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}visit_date'])!,
      healthStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}health_status'])!,
      fever: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}fever'])!,
      cough: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}cough'])!,
      diarrhea: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}diarrhea'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      followUpRequired: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}follow_up_required'])!,
      locationLat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}location_lat']),
      locationLng: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}location_lng']),
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $VisitsTableTable createAlias(String alias) {
    return $VisitsTableTable(attachedDatabase, alias);
  }
}

class VisitsTableData extends DataClass implements Insertable<VisitsTableData> {
  final String id;
  final String familyId;
  final DateTime visitDate;
  final String healthStatus;
  final bool fever;
  final bool cough;
  final bool diarrhea;
  final String? notes;
  final bool followUpRequired;
  final double? locationLat;
  final double? locationLng;
  final String? photoPath;
  final int syncStatus;
  const VisitsTableData(
      {required this.id,
      required this.familyId,
      required this.visitDate,
      required this.healthStatus,
      required this.fever,
      required this.cough,
      required this.diarrhea,
      this.notes,
      required this.followUpRequired,
      this.locationLat,
      this.locationLng,
      this.photoPath,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['family_id'] = Variable<String>(familyId);
    map['visit_date'] = Variable<DateTime>(visitDate);
    map['health_status'] = Variable<String>(healthStatus);
    map['fever'] = Variable<bool>(fever);
    map['cough'] = Variable<bool>(cough);
    map['diarrhea'] = Variable<bool>(diarrhea);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['follow_up_required'] = Variable<bool>(followUpRequired);
    if (!nullToAbsent || locationLat != null) {
      map['location_lat'] = Variable<double>(locationLat);
    }
    if (!nullToAbsent || locationLng != null) {
      map['location_lng'] = Variable<double>(locationLng);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['sync_status'] = Variable<int>(syncStatus);
    return map;
  }

  VisitsTableCompanion toCompanion(bool nullToAbsent) {
    return VisitsTableCompanion(
      id: Value(id),
      familyId: Value(familyId),
      visitDate: Value(visitDate),
      healthStatus: Value(healthStatus),
      fever: Value(fever),
      cough: Value(cough),
      diarrhea: Value(diarrhea),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      followUpRequired: Value(followUpRequired),
      locationLat: locationLat == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLat),
      locationLng: locationLng == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLng),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      syncStatus: Value(syncStatus),
    );
  }

  factory VisitsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VisitsTableData(
      id: serializer.fromJson<String>(json['id']),
      familyId: serializer.fromJson<String>(json['familyId']),
      visitDate: serializer.fromJson<DateTime>(json['visitDate']),
      healthStatus: serializer.fromJson<String>(json['healthStatus']),
      fever: serializer.fromJson<bool>(json['fever']),
      cough: serializer.fromJson<bool>(json['cough']),
      diarrhea: serializer.fromJson<bool>(json['diarrhea']),
      notes: serializer.fromJson<String?>(json['notes']),
      followUpRequired: serializer.fromJson<bool>(json['followUpRequired']),
      locationLat: serializer.fromJson<double?>(json['locationLat']),
      locationLng: serializer.fromJson<double?>(json['locationLng']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'familyId': serializer.toJson<String>(familyId),
      'visitDate': serializer.toJson<DateTime>(visitDate),
      'healthStatus': serializer.toJson<String>(healthStatus),
      'fever': serializer.toJson<bool>(fever),
      'cough': serializer.toJson<bool>(cough),
      'diarrhea': serializer.toJson<bool>(diarrhea),
      'notes': serializer.toJson<String?>(notes),
      'followUpRequired': serializer.toJson<bool>(followUpRequired),
      'locationLat': serializer.toJson<double?>(locationLat),
      'locationLng': serializer.toJson<double?>(locationLng),
      'photoPath': serializer.toJson<String?>(photoPath),
      'syncStatus': serializer.toJson<int>(syncStatus),
    };
  }

  VisitsTableData copyWith(
          {String? id,
          String? familyId,
          DateTime? visitDate,
          String? healthStatus,
          bool? fever,
          bool? cough,
          bool? diarrhea,
          Value<String?> notes = const Value.absent(),
          bool? followUpRequired,
          Value<double?> locationLat = const Value.absent(),
          Value<double?> locationLng = const Value.absent(),
          Value<String?> photoPath = const Value.absent(),
          int? syncStatus}) =>
      VisitsTableData(
        id: id ?? this.id,
        familyId: familyId ?? this.familyId,
        visitDate: visitDate ?? this.visitDate,
        healthStatus: healthStatus ?? this.healthStatus,
        fever: fever ?? this.fever,
        cough: cough ?? this.cough,
        diarrhea: diarrhea ?? this.diarrhea,
        notes: notes.present ? notes.value : this.notes,
        followUpRequired: followUpRequired ?? this.followUpRequired,
        locationLat: locationLat.present ? locationLat.value : this.locationLat,
        locationLng: locationLng.present ? locationLng.value : this.locationLng,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  VisitsTableData copyWithCompanion(VisitsTableCompanion data) {
    return VisitsTableData(
      id: data.id.present ? data.id.value : this.id,
      familyId: data.familyId.present ? data.familyId.value : this.familyId,
      visitDate: data.visitDate.present ? data.visitDate.value : this.visitDate,
      healthStatus: data.healthStatus.present
          ? data.healthStatus.value
          : this.healthStatus,
      fever: data.fever.present ? data.fever.value : this.fever,
      cough: data.cough.present ? data.cough.value : this.cough,
      diarrhea: data.diarrhea.present ? data.diarrhea.value : this.diarrhea,
      notes: data.notes.present ? data.notes.value : this.notes,
      followUpRequired: data.followUpRequired.present
          ? data.followUpRequired.value
          : this.followUpRequired,
      locationLat:
          data.locationLat.present ? data.locationLat.value : this.locationLat,
      locationLng:
          data.locationLng.present ? data.locationLng.value : this.locationLng,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VisitsTableData(')
          ..write('id: $id, ')
          ..write('familyId: $familyId, ')
          ..write('visitDate: $visitDate, ')
          ..write('healthStatus: $healthStatus, ')
          ..write('fever: $fever, ')
          ..write('cough: $cough, ')
          ..write('diarrhea: $diarrhea, ')
          ..write('notes: $notes, ')
          ..write('followUpRequired: $followUpRequired, ')
          ..write('locationLat: $locationLat, ')
          ..write('locationLng: $locationLng, ')
          ..write('photoPath: $photoPath, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      familyId,
      visitDate,
      healthStatus,
      fever,
      cough,
      diarrhea,
      notes,
      followUpRequired,
      locationLat,
      locationLng,
      photoPath,
      syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VisitsTableData &&
          other.id == this.id &&
          other.familyId == this.familyId &&
          other.visitDate == this.visitDate &&
          other.healthStatus == this.healthStatus &&
          other.fever == this.fever &&
          other.cough == this.cough &&
          other.diarrhea == this.diarrhea &&
          other.notes == this.notes &&
          other.followUpRequired == this.followUpRequired &&
          other.locationLat == this.locationLat &&
          other.locationLng == this.locationLng &&
          other.photoPath == this.photoPath &&
          other.syncStatus == this.syncStatus);
}

class VisitsTableCompanion extends UpdateCompanion<VisitsTableData> {
  final Value<String> id;
  final Value<String> familyId;
  final Value<DateTime> visitDate;
  final Value<String> healthStatus;
  final Value<bool> fever;
  final Value<bool> cough;
  final Value<bool> diarrhea;
  final Value<String?> notes;
  final Value<bool> followUpRequired;
  final Value<double?> locationLat;
  final Value<double?> locationLng;
  final Value<String?> photoPath;
  final Value<int> syncStatus;
  final Value<int> rowid;
  const VisitsTableCompanion({
    this.id = const Value.absent(),
    this.familyId = const Value.absent(),
    this.visitDate = const Value.absent(),
    this.healthStatus = const Value.absent(),
    this.fever = const Value.absent(),
    this.cough = const Value.absent(),
    this.diarrhea = const Value.absent(),
    this.notes = const Value.absent(),
    this.followUpRequired = const Value.absent(),
    this.locationLat = const Value.absent(),
    this.locationLng = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VisitsTableCompanion.insert({
    required String id,
    required String familyId,
    required DateTime visitDate,
    required String healthStatus,
    required bool fever,
    required bool cough,
    required bool diarrhea,
    this.notes = const Value.absent(),
    required bool followUpRequired,
    this.locationLat = const Value.absent(),
    this.locationLng = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        familyId = Value(familyId),
        visitDate = Value(visitDate),
        healthStatus = Value(healthStatus),
        fever = Value(fever),
        cough = Value(cough),
        diarrhea = Value(diarrhea),
        followUpRequired = Value(followUpRequired);
  static Insertable<VisitsTableData> custom({
    Expression<String>? id,
    Expression<String>? familyId,
    Expression<DateTime>? visitDate,
    Expression<String>? healthStatus,
    Expression<bool>? fever,
    Expression<bool>? cough,
    Expression<bool>? diarrhea,
    Expression<String>? notes,
    Expression<bool>? followUpRequired,
    Expression<double>? locationLat,
    Expression<double>? locationLng,
    Expression<String>? photoPath,
    Expression<int>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (familyId != null) 'family_id': familyId,
      if (visitDate != null) 'visit_date': visitDate,
      if (healthStatus != null) 'health_status': healthStatus,
      if (fever != null) 'fever': fever,
      if (cough != null) 'cough': cough,
      if (diarrhea != null) 'diarrhea': diarrhea,
      if (notes != null) 'notes': notes,
      if (followUpRequired != null) 'follow_up_required': followUpRequired,
      if (locationLat != null) 'location_lat': locationLat,
      if (locationLng != null) 'location_lng': locationLng,
      if (photoPath != null) 'photo_path': photoPath,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VisitsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? familyId,
      Value<DateTime>? visitDate,
      Value<String>? healthStatus,
      Value<bool>? fever,
      Value<bool>? cough,
      Value<bool>? diarrhea,
      Value<String?>? notes,
      Value<bool>? followUpRequired,
      Value<double?>? locationLat,
      Value<double?>? locationLng,
      Value<String?>? photoPath,
      Value<int>? syncStatus,
      Value<int>? rowid}) {
    return VisitsTableCompanion(
      id: id ?? this.id,
      familyId: familyId ?? this.familyId,
      visitDate: visitDate ?? this.visitDate,
      healthStatus: healthStatus ?? this.healthStatus,
      fever: fever ?? this.fever,
      cough: cough ?? this.cough,
      diarrhea: diarrhea ?? this.diarrhea,
      notes: notes ?? this.notes,
      followUpRequired: followUpRequired ?? this.followUpRequired,
      locationLat: locationLat ?? this.locationLat,
      locationLng: locationLng ?? this.locationLng,
      photoPath: photoPath ?? this.photoPath,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (familyId.present) {
      map['family_id'] = Variable<String>(familyId.value);
    }
    if (visitDate.present) {
      map['visit_date'] = Variable<DateTime>(visitDate.value);
    }
    if (healthStatus.present) {
      map['health_status'] = Variable<String>(healthStatus.value);
    }
    if (fever.present) {
      map['fever'] = Variable<bool>(fever.value);
    }
    if (cough.present) {
      map['cough'] = Variable<bool>(cough.value);
    }
    if (diarrhea.present) {
      map['diarrhea'] = Variable<bool>(diarrhea.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (followUpRequired.present) {
      map['follow_up_required'] = Variable<bool>(followUpRequired.value);
    }
    if (locationLat.present) {
      map['location_lat'] = Variable<double>(locationLat.value);
    }
    if (locationLng.present) {
      map['location_lng'] = Variable<double>(locationLng.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitsTableCompanion(')
          ..write('id: $id, ')
          ..write('familyId: $familyId, ')
          ..write('visitDate: $visitDate, ')
          ..write('healthStatus: $healthStatus, ')
          ..write('fever: $fever, ')
          ..write('cough: $cough, ')
          ..write('diarrhea: $diarrhea, ')
          ..write('notes: $notes, ')
          ..write('followUpRequired: $followUpRequired, ')
          ..write('locationLat: $locationLat, ')
          ..write('locationLng: $locationLng, ')
          ..write('photoPath: $photoPath, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ReportsTableTable reportsTable = $ReportsTableTable(this);
  late final $FamiliesTableTable familiesTable = $FamiliesTableTable(this);
  late final $ChildrenTableTable childrenTable = $ChildrenTableTable(this);
  late final $GrowthMeasurementsTableTable growthMeasurementsTable =
      $GrowthMeasurementsTableTable(this);
  late final $VaccinationsTableTable vaccinationsTable =
      $VaccinationsTableTable(this);
  late final $VisitsTableTable visitsTable = $VisitsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        reportsTable,
        familiesTable,
        childrenTable,
        growthMeasurementsTable,
        vaccinationsTable,
        visitsTable
      ];
}

typedef $$ReportsTableTableCreateCompanionBuilder = ReportsTableCompanion
    Function({
  required String id,
  required String workerId,
  required String workerName,
  required String wardCode,
  required DateTime reportDate,
  required DateTime submissionTime,
  required int feverCount,
  required int coughCount,
  required int diarrheaCount,
  required int jaundiceCount,
  required int rashCount,
  Value<String?> diseaseType,
  required String maternalRiskFlags,
  required String childRiskFlags,
  required String environmentalFlags,
  Value<double?> locationLat,
  Value<double?> locationLng,
  Value<String> photoPaths,
  Value<int> syncStatus,
  Value<int> rowid,
});
typedef $$ReportsTableTableUpdateCompanionBuilder = ReportsTableCompanion
    Function({
  Value<String> id,
  Value<String> workerId,
  Value<String> workerName,
  Value<String> wardCode,
  Value<DateTime> reportDate,
  Value<DateTime> submissionTime,
  Value<int> feverCount,
  Value<int> coughCount,
  Value<int> diarrheaCount,
  Value<int> jaundiceCount,
  Value<int> rashCount,
  Value<String?> diseaseType,
  Value<String> maternalRiskFlags,
  Value<String> childRiskFlags,
  Value<String> environmentalFlags,
  Value<double?> locationLat,
  Value<double?> locationLng,
  Value<String> photoPaths,
  Value<int> syncStatus,
  Value<int> rowid,
});

class $$ReportsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ReportsTableTable> {
  $$ReportsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workerId => $composableBuilder(
      column: $table.workerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workerName => $composableBuilder(
      column: $table.workerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wardCode => $composableBuilder(
      column: $table.wardCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get reportDate => $composableBuilder(
      column: $table.reportDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get submissionTime => $composableBuilder(
      column: $table.submissionTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get feverCount => $composableBuilder(
      column: $table.feverCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get coughCount => $composableBuilder(
      column: $table.coughCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diarrheaCount => $composableBuilder(
      column: $table.diarrheaCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get jaundiceCount => $composableBuilder(
      column: $table.jaundiceCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rashCount => $composableBuilder(
      column: $table.rashCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get diseaseType => $composableBuilder(
      column: $table.diseaseType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get maternalRiskFlags => $composableBuilder(
      column: $table.maternalRiskFlags,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get childRiskFlags => $composableBuilder(
      column: $table.childRiskFlags,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get environmentalFlags => $composableBuilder(
      column: $table.environmentalFlags,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get locationLat => $composableBuilder(
      column: $table.locationLat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get locationLng => $composableBuilder(
      column: $table.locationLng, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPaths => $composableBuilder(
      column: $table.photoPaths, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));
}

class $$ReportsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ReportsTableTable> {
  $$ReportsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workerId => $composableBuilder(
      column: $table.workerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workerName => $composableBuilder(
      column: $table.workerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wardCode => $composableBuilder(
      column: $table.wardCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get reportDate => $composableBuilder(
      column: $table.reportDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get submissionTime => $composableBuilder(
      column: $table.submissionTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get feverCount => $composableBuilder(
      column: $table.feverCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get coughCount => $composableBuilder(
      column: $table.coughCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diarrheaCount => $composableBuilder(
      column: $table.diarrheaCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get jaundiceCount => $composableBuilder(
      column: $table.jaundiceCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rashCount => $composableBuilder(
      column: $table.rashCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get diseaseType => $composableBuilder(
      column: $table.diseaseType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get maternalRiskFlags => $composableBuilder(
      column: $table.maternalRiskFlags,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get childRiskFlags => $composableBuilder(
      column: $table.childRiskFlags,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get environmentalFlags => $composableBuilder(
      column: $table.environmentalFlags,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get locationLat => $composableBuilder(
      column: $table.locationLat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get locationLng => $composableBuilder(
      column: $table.locationLng, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPaths => $composableBuilder(
      column: $table.photoPaths, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
}

class $$ReportsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReportsTableTable> {
  $$ReportsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workerId =>
      $composableBuilder(column: $table.workerId, builder: (column) => column);

  GeneratedColumn<String> get workerName => $composableBuilder(
      column: $table.workerName, builder: (column) => column);

  GeneratedColumn<String> get wardCode =>
      $composableBuilder(column: $table.wardCode, builder: (column) => column);

  GeneratedColumn<DateTime> get reportDate => $composableBuilder(
      column: $table.reportDate, builder: (column) => column);

  GeneratedColumn<DateTime> get submissionTime => $composableBuilder(
      column: $table.submissionTime, builder: (column) => column);

  GeneratedColumn<int> get feverCount => $composableBuilder(
      column: $table.feverCount, builder: (column) => column);

  GeneratedColumn<int> get coughCount => $composableBuilder(
      column: $table.coughCount, builder: (column) => column);

  GeneratedColumn<int> get diarrheaCount => $composableBuilder(
      column: $table.diarrheaCount, builder: (column) => column);

  GeneratedColumn<int> get jaundiceCount => $composableBuilder(
      column: $table.jaundiceCount, builder: (column) => column);

  GeneratedColumn<int> get rashCount =>
      $composableBuilder(column: $table.rashCount, builder: (column) => column);

  GeneratedColumn<String> get diseaseType => $composableBuilder(
      column: $table.diseaseType, builder: (column) => column);

  GeneratedColumn<String> get maternalRiskFlags => $composableBuilder(
      column: $table.maternalRiskFlags, builder: (column) => column);

  GeneratedColumn<String> get childRiskFlags => $composableBuilder(
      column: $table.childRiskFlags, builder: (column) => column);

  GeneratedColumn<String> get environmentalFlags => $composableBuilder(
      column: $table.environmentalFlags, builder: (column) => column);

  GeneratedColumn<double> get locationLat => $composableBuilder(
      column: $table.locationLat, builder: (column) => column);

  GeneratedColumn<double> get locationLng => $composableBuilder(
      column: $table.locationLng, builder: (column) => column);

  GeneratedColumn<String> get photoPaths => $composableBuilder(
      column: $table.photoPaths, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);
}

class $$ReportsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReportsTableTable,
    ReportsTableData,
    $$ReportsTableTableFilterComposer,
    $$ReportsTableTableOrderingComposer,
    $$ReportsTableTableAnnotationComposer,
    $$ReportsTableTableCreateCompanionBuilder,
    $$ReportsTableTableUpdateCompanionBuilder,
    (
      ReportsTableData,
      BaseReferences<_$AppDatabase, $ReportsTableTable, ReportsTableData>
    ),
    ReportsTableData,
    PrefetchHooks Function()> {
  $$ReportsTableTableTableManager(_$AppDatabase db, $ReportsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReportsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReportsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReportsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workerId = const Value.absent(),
            Value<String> workerName = const Value.absent(),
            Value<String> wardCode = const Value.absent(),
            Value<DateTime> reportDate = const Value.absent(),
            Value<DateTime> submissionTime = const Value.absent(),
            Value<int> feverCount = const Value.absent(),
            Value<int> coughCount = const Value.absent(),
            Value<int> diarrheaCount = const Value.absent(),
            Value<int> jaundiceCount = const Value.absent(),
            Value<int> rashCount = const Value.absent(),
            Value<String?> diseaseType = const Value.absent(),
            Value<String> maternalRiskFlags = const Value.absent(),
            Value<String> childRiskFlags = const Value.absent(),
            Value<String> environmentalFlags = const Value.absent(),
            Value<double?> locationLat = const Value.absent(),
            Value<double?> locationLng = const Value.absent(),
            Value<String> photoPaths = const Value.absent(),
            Value<int> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReportsTableCompanion(
            id: id,
            workerId: workerId,
            workerName: workerName,
            wardCode: wardCode,
            reportDate: reportDate,
            submissionTime: submissionTime,
            feverCount: feverCount,
            coughCount: coughCount,
            diarrheaCount: diarrheaCount,
            jaundiceCount: jaundiceCount,
            rashCount: rashCount,
            diseaseType: diseaseType,
            maternalRiskFlags: maternalRiskFlags,
            childRiskFlags: childRiskFlags,
            environmentalFlags: environmentalFlags,
            locationLat: locationLat,
            locationLng: locationLng,
            photoPaths: photoPaths,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workerId,
            required String workerName,
            required String wardCode,
            required DateTime reportDate,
            required DateTime submissionTime,
            required int feverCount,
            required int coughCount,
            required int diarrheaCount,
            required int jaundiceCount,
            required int rashCount,
            Value<String?> diseaseType = const Value.absent(),
            required String maternalRiskFlags,
            required String childRiskFlags,
            required String environmentalFlags,
            Value<double?> locationLat = const Value.absent(),
            Value<double?> locationLng = const Value.absent(),
            Value<String> photoPaths = const Value.absent(),
            Value<int> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReportsTableCompanion.insert(
            id: id,
            workerId: workerId,
            workerName: workerName,
            wardCode: wardCode,
            reportDate: reportDate,
            submissionTime: submissionTime,
            feverCount: feverCount,
            coughCount: coughCount,
            diarrheaCount: diarrheaCount,
            jaundiceCount: jaundiceCount,
            rashCount: rashCount,
            diseaseType: diseaseType,
            maternalRiskFlags: maternalRiskFlags,
            childRiskFlags: childRiskFlags,
            environmentalFlags: environmentalFlags,
            locationLat: locationLat,
            locationLng: locationLng,
            photoPaths: photoPaths,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ReportsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReportsTableTable,
    ReportsTableData,
    $$ReportsTableTableFilterComposer,
    $$ReportsTableTableOrderingComposer,
    $$ReportsTableTableAnnotationComposer,
    $$ReportsTableTableCreateCompanionBuilder,
    $$ReportsTableTableUpdateCompanionBuilder,
    (
      ReportsTableData,
      BaseReferences<_$AppDatabase, $ReportsTableTable, ReportsTableData>
    ),
    ReportsTableData,
    PrefetchHooks Function()>;
typedef $$FamiliesTableTableCreateCompanionBuilder = FamiliesTableCompanion
    Function({
  required String id,
  required String familyName,
  required String headName,
  required String wardCode,
  required String address,
  Value<String?> contactNumber,
  required int totalMembers,
  required int pregnantWomenCount,
  required int childrenCount,
  required bool highRiskFlag,
  required DateTime createdAt,
  Value<DateTime?> lastVisit,
  Value<int> syncStatus,
  Value<int> rowid,
});
typedef $$FamiliesTableTableUpdateCompanionBuilder = FamiliesTableCompanion
    Function({
  Value<String> id,
  Value<String> familyName,
  Value<String> headName,
  Value<String> wardCode,
  Value<String> address,
  Value<String?> contactNumber,
  Value<int> totalMembers,
  Value<int> pregnantWomenCount,
  Value<int> childrenCount,
  Value<bool> highRiskFlag,
  Value<DateTime> createdAt,
  Value<DateTime?> lastVisit,
  Value<int> syncStatus,
  Value<int> rowid,
});

class $$FamiliesTableTableFilterComposer
    extends Composer<_$AppDatabase, $FamiliesTableTable> {
  $$FamiliesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get familyName => $composableBuilder(
      column: $table.familyName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get headName => $composableBuilder(
      column: $table.headName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wardCode => $composableBuilder(
      column: $table.wardCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contactNumber => $composableBuilder(
      column: $table.contactNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalMembers => $composableBuilder(
      column: $table.totalMembers, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pregnantWomenCount => $composableBuilder(
      column: $table.pregnantWomenCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get childrenCount => $composableBuilder(
      column: $table.childrenCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get highRiskFlag => $composableBuilder(
      column: $table.highRiskFlag, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastVisit => $composableBuilder(
      column: $table.lastVisit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));
}

class $$FamiliesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FamiliesTableTable> {
  $$FamiliesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get familyName => $composableBuilder(
      column: $table.familyName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get headName => $composableBuilder(
      column: $table.headName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wardCode => $composableBuilder(
      column: $table.wardCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contactNumber => $composableBuilder(
      column: $table.contactNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalMembers => $composableBuilder(
      column: $table.totalMembers,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pregnantWomenCount => $composableBuilder(
      column: $table.pregnantWomenCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get childrenCount => $composableBuilder(
      column: $table.childrenCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get highRiskFlag => $composableBuilder(
      column: $table.highRiskFlag,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastVisit => $composableBuilder(
      column: $table.lastVisit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
}

class $$FamiliesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FamiliesTableTable> {
  $$FamiliesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get familyName => $composableBuilder(
      column: $table.familyName, builder: (column) => column);

  GeneratedColumn<String> get headName =>
      $composableBuilder(column: $table.headName, builder: (column) => column);

  GeneratedColumn<String> get wardCode =>
      $composableBuilder(column: $table.wardCode, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get contactNumber => $composableBuilder(
      column: $table.contactNumber, builder: (column) => column);

  GeneratedColumn<int> get totalMembers => $composableBuilder(
      column: $table.totalMembers, builder: (column) => column);

  GeneratedColumn<int> get pregnantWomenCount => $composableBuilder(
      column: $table.pregnantWomenCount, builder: (column) => column);

  GeneratedColumn<int> get childrenCount => $composableBuilder(
      column: $table.childrenCount, builder: (column) => column);

  GeneratedColumn<bool> get highRiskFlag => $composableBuilder(
      column: $table.highRiskFlag, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastVisit =>
      $composableBuilder(column: $table.lastVisit, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);
}

class $$FamiliesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FamiliesTableTable,
    FamiliesTableData,
    $$FamiliesTableTableFilterComposer,
    $$FamiliesTableTableOrderingComposer,
    $$FamiliesTableTableAnnotationComposer,
    $$FamiliesTableTableCreateCompanionBuilder,
    $$FamiliesTableTableUpdateCompanionBuilder,
    (
      FamiliesTableData,
      BaseReferences<_$AppDatabase, $FamiliesTableTable, FamiliesTableData>
    ),
    FamiliesTableData,
    PrefetchHooks Function()> {
  $$FamiliesTableTableTableManager(_$AppDatabase db, $FamiliesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FamiliesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FamiliesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FamiliesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> familyName = const Value.absent(),
            Value<String> headName = const Value.absent(),
            Value<String> wardCode = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<String?> contactNumber = const Value.absent(),
            Value<int> totalMembers = const Value.absent(),
            Value<int> pregnantWomenCount = const Value.absent(),
            Value<int> childrenCount = const Value.absent(),
            Value<bool> highRiskFlag = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastVisit = const Value.absent(),
            Value<int> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FamiliesTableCompanion(
            id: id,
            familyName: familyName,
            headName: headName,
            wardCode: wardCode,
            address: address,
            contactNumber: contactNumber,
            totalMembers: totalMembers,
            pregnantWomenCount: pregnantWomenCount,
            childrenCount: childrenCount,
            highRiskFlag: highRiskFlag,
            createdAt: createdAt,
            lastVisit: lastVisit,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String familyName,
            required String headName,
            required String wardCode,
            required String address,
            Value<String?> contactNumber = const Value.absent(),
            required int totalMembers,
            required int pregnantWomenCount,
            required int childrenCount,
            required bool highRiskFlag,
            required DateTime createdAt,
            Value<DateTime?> lastVisit = const Value.absent(),
            Value<int> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FamiliesTableCompanion.insert(
            id: id,
            familyName: familyName,
            headName: headName,
            wardCode: wardCode,
            address: address,
            contactNumber: contactNumber,
            totalMembers: totalMembers,
            pregnantWomenCount: pregnantWomenCount,
            childrenCount: childrenCount,
            highRiskFlag: highRiskFlag,
            createdAt: createdAt,
            lastVisit: lastVisit,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FamiliesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FamiliesTableTable,
    FamiliesTableData,
    $$FamiliesTableTableFilterComposer,
    $$FamiliesTableTableOrderingComposer,
    $$FamiliesTableTableAnnotationComposer,
    $$FamiliesTableTableCreateCompanionBuilder,
    $$FamiliesTableTableUpdateCompanionBuilder,
    (
      FamiliesTableData,
      BaseReferences<_$AppDatabase, $FamiliesTableTable, FamiliesTableData>
    ),
    FamiliesTableData,
    PrefetchHooks Function()>;
typedef $$ChildrenTableTableCreateCompanionBuilder = ChildrenTableCompanion
    Function({
  required String id,
  required String familyId,
  required String name,
  required DateTime dateOfBirth,
  required String gender,
  Value<String?> bloodGroup,
  Value<String> nutritionStatus,
  required DateTime createdAt,
  Value<int> syncStatus,
  Value<int> rowid,
});
typedef $$ChildrenTableTableUpdateCompanionBuilder = ChildrenTableCompanion
    Function({
  Value<String> id,
  Value<String> familyId,
  Value<String> name,
  Value<DateTime> dateOfBirth,
  Value<String> gender,
  Value<String?> bloodGroup,
  Value<String> nutritionStatus,
  Value<DateTime> createdAt,
  Value<int> syncStatus,
  Value<int> rowid,
});

class $$ChildrenTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChildrenTableTable> {
  $$ChildrenTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get familyId => $composableBuilder(
      column: $table.familyId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bloodGroup => $composableBuilder(
      column: $table.bloodGroup, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nutritionStatus => $composableBuilder(
      column: $table.nutritionStatus,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));
}

class $$ChildrenTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChildrenTableTable> {
  $$ChildrenTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get familyId => $composableBuilder(
      column: $table.familyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bloodGroup => $composableBuilder(
      column: $table.bloodGroup, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nutritionStatus => $composableBuilder(
      column: $table.nutritionStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
}

class $$ChildrenTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChildrenTableTable> {
  $$ChildrenTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get familyId =>
      $composableBuilder(column: $table.familyId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get bloodGroup => $composableBuilder(
      column: $table.bloodGroup, builder: (column) => column);

  GeneratedColumn<String> get nutritionStatus => $composableBuilder(
      column: $table.nutritionStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);
}

class $$ChildrenTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChildrenTableTable,
    ChildrenTableData,
    $$ChildrenTableTableFilterComposer,
    $$ChildrenTableTableOrderingComposer,
    $$ChildrenTableTableAnnotationComposer,
    $$ChildrenTableTableCreateCompanionBuilder,
    $$ChildrenTableTableUpdateCompanionBuilder,
    (
      ChildrenTableData,
      BaseReferences<_$AppDatabase, $ChildrenTableTable, ChildrenTableData>
    ),
    ChildrenTableData,
    PrefetchHooks Function()> {
  $$ChildrenTableTableTableManager(_$AppDatabase db, $ChildrenTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChildrenTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChildrenTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChildrenTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> familyId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> dateOfBirth = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<String?> bloodGroup = const Value.absent(),
            Value<String> nutritionStatus = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildrenTableCompanion(
            id: id,
            familyId: familyId,
            name: name,
            dateOfBirth: dateOfBirth,
            gender: gender,
            bloodGroup: bloodGroup,
            nutritionStatus: nutritionStatus,
            createdAt: createdAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String familyId,
            required String name,
            required DateTime dateOfBirth,
            required String gender,
            Value<String?> bloodGroup = const Value.absent(),
            Value<String> nutritionStatus = const Value.absent(),
            required DateTime createdAt,
            Value<int> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildrenTableCompanion.insert(
            id: id,
            familyId: familyId,
            name: name,
            dateOfBirth: dateOfBirth,
            gender: gender,
            bloodGroup: bloodGroup,
            nutritionStatus: nutritionStatus,
            createdAt: createdAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChildrenTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChildrenTableTable,
    ChildrenTableData,
    $$ChildrenTableTableFilterComposer,
    $$ChildrenTableTableOrderingComposer,
    $$ChildrenTableTableAnnotationComposer,
    $$ChildrenTableTableCreateCompanionBuilder,
    $$ChildrenTableTableUpdateCompanionBuilder,
    (
      ChildrenTableData,
      BaseReferences<_$AppDatabase, $ChildrenTableTable, ChildrenTableData>
    ),
    ChildrenTableData,
    PrefetchHooks Function()>;
typedef $$GrowthMeasurementsTableTableCreateCompanionBuilder
    = GrowthMeasurementsTableCompanion Function({
  Value<int> id,
  required String childId,
  required DateTime measuredAt,
  required double weightKg,
  required double heightCm,
  required int ageMonths,
  required String nutritionStatus,
  Value<String?> notes,
  Value<int> syncStatus,
});
typedef $$GrowthMeasurementsTableTableUpdateCompanionBuilder
    = GrowthMeasurementsTableCompanion Function({
  Value<int> id,
  Value<String> childId,
  Value<DateTime> measuredAt,
  Value<double> weightKg,
  Value<double> heightCm,
  Value<int> ageMonths,
  Value<String> nutritionStatus,
  Value<String?> notes,
  Value<int> syncStatus,
});

class $$GrowthMeasurementsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GrowthMeasurementsTableTable> {
  $$GrowthMeasurementsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get heightCm => $composableBuilder(
      column: $table.heightCm, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ageMonths => $composableBuilder(
      column: $table.ageMonths, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nutritionStatus => $composableBuilder(
      column: $table.nutritionStatus,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));
}

class $$GrowthMeasurementsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GrowthMeasurementsTableTable> {
  $$GrowthMeasurementsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get heightCm => $composableBuilder(
      column: $table.heightCm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ageMonths => $composableBuilder(
      column: $table.ageMonths, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nutritionStatus => $composableBuilder(
      column: $table.nutritionStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
}

class $$GrowthMeasurementsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrowthMeasurementsTableTable> {
  $$GrowthMeasurementsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<int> get ageMonths =>
      $composableBuilder(column: $table.ageMonths, builder: (column) => column);

  GeneratedColumn<String> get nutritionStatus => $composableBuilder(
      column: $table.nutritionStatus, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);
}

class $$GrowthMeasurementsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GrowthMeasurementsTableTable,
    GrowthMeasurementsTableData,
    $$GrowthMeasurementsTableTableFilterComposer,
    $$GrowthMeasurementsTableTableOrderingComposer,
    $$GrowthMeasurementsTableTableAnnotationComposer,
    $$GrowthMeasurementsTableTableCreateCompanionBuilder,
    $$GrowthMeasurementsTableTableUpdateCompanionBuilder,
    (
      GrowthMeasurementsTableData,
      BaseReferences<_$AppDatabase, $GrowthMeasurementsTableTable,
          GrowthMeasurementsTableData>
    ),
    GrowthMeasurementsTableData,
    PrefetchHooks Function()> {
  $$GrowthMeasurementsTableTableTableManager(
      _$AppDatabase db, $GrowthMeasurementsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrowthMeasurementsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$GrowthMeasurementsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrowthMeasurementsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> childId = const Value.absent(),
            Value<DateTime> measuredAt = const Value.absent(),
            Value<double> weightKg = const Value.absent(),
            Value<double> heightCm = const Value.absent(),
            Value<int> ageMonths = const Value.absent(),
            Value<String> nutritionStatus = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> syncStatus = const Value.absent(),
          }) =>
              GrowthMeasurementsTableCompanion(
            id: id,
            childId: childId,
            measuredAt: measuredAt,
            weightKg: weightKg,
            heightCm: heightCm,
            ageMonths: ageMonths,
            nutritionStatus: nutritionStatus,
            notes: notes,
            syncStatus: syncStatus,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String childId,
            required DateTime measuredAt,
            required double weightKg,
            required double heightCm,
            required int ageMonths,
            required String nutritionStatus,
            Value<String?> notes = const Value.absent(),
            Value<int> syncStatus = const Value.absent(),
          }) =>
              GrowthMeasurementsTableCompanion.insert(
            id: id,
            childId: childId,
            measuredAt: measuredAt,
            weightKg: weightKg,
            heightCm: heightCm,
            ageMonths: ageMonths,
            nutritionStatus: nutritionStatus,
            notes: notes,
            syncStatus: syncStatus,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GrowthMeasurementsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $GrowthMeasurementsTableTable,
        GrowthMeasurementsTableData,
        $$GrowthMeasurementsTableTableFilterComposer,
        $$GrowthMeasurementsTableTableOrderingComposer,
        $$GrowthMeasurementsTableTableAnnotationComposer,
        $$GrowthMeasurementsTableTableCreateCompanionBuilder,
        $$GrowthMeasurementsTableTableUpdateCompanionBuilder,
        (
          GrowthMeasurementsTableData,
          BaseReferences<_$AppDatabase, $GrowthMeasurementsTableTable,
              GrowthMeasurementsTableData>
        ),
        GrowthMeasurementsTableData,
        PrefetchHooks Function()>;
typedef $$VaccinationsTableTableCreateCompanionBuilder
    = VaccinationsTableCompanion Function({
  Value<int> id,
  required String childId,
  required String vaccineName,
  required int doseNumber,
  required DateTime dateGiven,
  Value<DateTime?> nextDueDate,
  Value<String?> remarks,
  Value<int> syncStatus,
});
typedef $$VaccinationsTableTableUpdateCompanionBuilder
    = VaccinationsTableCompanion Function({
  Value<int> id,
  Value<String> childId,
  Value<String> vaccineName,
  Value<int> doseNumber,
  Value<DateTime> dateGiven,
  Value<DateTime?> nextDueDate,
  Value<String?> remarks,
  Value<int> syncStatus,
});

class $$VaccinationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $VaccinationsTableTable> {
  $$VaccinationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get vaccineName => $composableBuilder(
      column: $table.vaccineName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get doseNumber => $composableBuilder(
      column: $table.doseNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateGiven => $composableBuilder(
      column: $table.dateGiven, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextDueDate => $composableBuilder(
      column: $table.nextDueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remarks => $composableBuilder(
      column: $table.remarks, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));
}

class $$VaccinationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VaccinationsTableTable> {
  $$VaccinationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get vaccineName => $composableBuilder(
      column: $table.vaccineName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get doseNumber => $composableBuilder(
      column: $table.doseNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateGiven => $composableBuilder(
      column: $table.dateGiven, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextDueDate => $composableBuilder(
      column: $table.nextDueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remarks => $composableBuilder(
      column: $table.remarks, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
}

class $$VaccinationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VaccinationsTableTable> {
  $$VaccinationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get vaccineName => $composableBuilder(
      column: $table.vaccineName, builder: (column) => column);

  GeneratedColumn<int> get doseNumber => $composableBuilder(
      column: $table.doseNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get dateGiven =>
      $composableBuilder(column: $table.dateGiven, builder: (column) => column);

  GeneratedColumn<DateTime> get nextDueDate => $composableBuilder(
      column: $table.nextDueDate, builder: (column) => column);

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);
}

class $$VaccinationsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VaccinationsTableTable,
    VaccinationsTableData,
    $$VaccinationsTableTableFilterComposer,
    $$VaccinationsTableTableOrderingComposer,
    $$VaccinationsTableTableAnnotationComposer,
    $$VaccinationsTableTableCreateCompanionBuilder,
    $$VaccinationsTableTableUpdateCompanionBuilder,
    (
      VaccinationsTableData,
      BaseReferences<_$AppDatabase, $VaccinationsTableTable,
          VaccinationsTableData>
    ),
    VaccinationsTableData,
    PrefetchHooks Function()> {
  $$VaccinationsTableTableTableManager(
      _$AppDatabase db, $VaccinationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VaccinationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VaccinationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VaccinationsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> childId = const Value.absent(),
            Value<String> vaccineName = const Value.absent(),
            Value<int> doseNumber = const Value.absent(),
            Value<DateTime> dateGiven = const Value.absent(),
            Value<DateTime?> nextDueDate = const Value.absent(),
            Value<String?> remarks = const Value.absent(),
            Value<int> syncStatus = const Value.absent(),
          }) =>
              VaccinationsTableCompanion(
            id: id,
            childId: childId,
            vaccineName: vaccineName,
            doseNumber: doseNumber,
            dateGiven: dateGiven,
            nextDueDate: nextDueDate,
            remarks: remarks,
            syncStatus: syncStatus,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String childId,
            required String vaccineName,
            required int doseNumber,
            required DateTime dateGiven,
            Value<DateTime?> nextDueDate = const Value.absent(),
            Value<String?> remarks = const Value.absent(),
            Value<int> syncStatus = const Value.absent(),
          }) =>
              VaccinationsTableCompanion.insert(
            id: id,
            childId: childId,
            vaccineName: vaccineName,
            doseNumber: doseNumber,
            dateGiven: dateGiven,
            nextDueDate: nextDueDate,
            remarks: remarks,
            syncStatus: syncStatus,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VaccinationsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VaccinationsTableTable,
    VaccinationsTableData,
    $$VaccinationsTableTableFilterComposer,
    $$VaccinationsTableTableOrderingComposer,
    $$VaccinationsTableTableAnnotationComposer,
    $$VaccinationsTableTableCreateCompanionBuilder,
    $$VaccinationsTableTableUpdateCompanionBuilder,
    (
      VaccinationsTableData,
      BaseReferences<_$AppDatabase, $VaccinationsTableTable,
          VaccinationsTableData>
    ),
    VaccinationsTableData,
    PrefetchHooks Function()>;
typedef $$VisitsTableTableCreateCompanionBuilder = VisitsTableCompanion
    Function({
  required String id,
  required String familyId,
  required DateTime visitDate,
  required String healthStatus,
  required bool fever,
  required bool cough,
  required bool diarrhea,
  Value<String?> notes,
  required bool followUpRequired,
  Value<double?> locationLat,
  Value<double?> locationLng,
  Value<String?> photoPath,
  Value<int> syncStatus,
  Value<int> rowid,
});
typedef $$VisitsTableTableUpdateCompanionBuilder = VisitsTableCompanion
    Function({
  Value<String> id,
  Value<String> familyId,
  Value<DateTime> visitDate,
  Value<String> healthStatus,
  Value<bool> fever,
  Value<bool> cough,
  Value<bool> diarrhea,
  Value<String?> notes,
  Value<bool> followUpRequired,
  Value<double?> locationLat,
  Value<double?> locationLng,
  Value<String?> photoPath,
  Value<int> syncStatus,
  Value<int> rowid,
});

class $$VisitsTableTableFilterComposer
    extends Composer<_$AppDatabase, $VisitsTableTable> {
  $$VisitsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get familyId => $composableBuilder(
      column: $table.familyId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get visitDate => $composableBuilder(
      column: $table.visitDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get healthStatus => $composableBuilder(
      column: $table.healthStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get fever => $composableBuilder(
      column: $table.fever, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get cough => $composableBuilder(
      column: $table.cough, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get diarrhea => $composableBuilder(
      column: $table.diarrhea, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get followUpRequired => $composableBuilder(
      column: $table.followUpRequired,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get locationLat => $composableBuilder(
      column: $table.locationLat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get locationLng => $composableBuilder(
      column: $table.locationLng, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));
}

class $$VisitsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VisitsTableTable> {
  $$VisitsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get familyId => $composableBuilder(
      column: $table.familyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get visitDate => $composableBuilder(
      column: $table.visitDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get healthStatus => $composableBuilder(
      column: $table.healthStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get fever => $composableBuilder(
      column: $table.fever, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get cough => $composableBuilder(
      column: $table.cough, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get diarrhea => $composableBuilder(
      column: $table.diarrhea, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get followUpRequired => $composableBuilder(
      column: $table.followUpRequired,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get locationLat => $composableBuilder(
      column: $table.locationLat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get locationLng => $composableBuilder(
      column: $table.locationLng, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
}

class $$VisitsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VisitsTableTable> {
  $$VisitsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get familyId =>
      $composableBuilder(column: $table.familyId, builder: (column) => column);

  GeneratedColumn<DateTime> get visitDate =>
      $composableBuilder(column: $table.visitDate, builder: (column) => column);

  GeneratedColumn<String> get healthStatus => $composableBuilder(
      column: $table.healthStatus, builder: (column) => column);

  GeneratedColumn<bool> get fever =>
      $composableBuilder(column: $table.fever, builder: (column) => column);

  GeneratedColumn<bool> get cough =>
      $composableBuilder(column: $table.cough, builder: (column) => column);

  GeneratedColumn<bool> get diarrhea =>
      $composableBuilder(column: $table.diarrhea, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get followUpRequired => $composableBuilder(
      column: $table.followUpRequired, builder: (column) => column);

  GeneratedColumn<double> get locationLat => $composableBuilder(
      column: $table.locationLat, builder: (column) => column);

  GeneratedColumn<double> get locationLng => $composableBuilder(
      column: $table.locationLng, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);
}

class $$VisitsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VisitsTableTable,
    VisitsTableData,
    $$VisitsTableTableFilterComposer,
    $$VisitsTableTableOrderingComposer,
    $$VisitsTableTableAnnotationComposer,
    $$VisitsTableTableCreateCompanionBuilder,
    $$VisitsTableTableUpdateCompanionBuilder,
    (
      VisitsTableData,
      BaseReferences<_$AppDatabase, $VisitsTableTable, VisitsTableData>
    ),
    VisitsTableData,
    PrefetchHooks Function()> {
  $$VisitsTableTableTableManager(_$AppDatabase db, $VisitsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VisitsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VisitsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VisitsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> familyId = const Value.absent(),
            Value<DateTime> visitDate = const Value.absent(),
            Value<String> healthStatus = const Value.absent(),
            Value<bool> fever = const Value.absent(),
            Value<bool> cough = const Value.absent(),
            Value<bool> diarrhea = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> followUpRequired = const Value.absent(),
            Value<double?> locationLat = const Value.absent(),
            Value<double?> locationLng = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<int> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VisitsTableCompanion(
            id: id,
            familyId: familyId,
            visitDate: visitDate,
            healthStatus: healthStatus,
            fever: fever,
            cough: cough,
            diarrhea: diarrhea,
            notes: notes,
            followUpRequired: followUpRequired,
            locationLat: locationLat,
            locationLng: locationLng,
            photoPath: photoPath,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String familyId,
            required DateTime visitDate,
            required String healthStatus,
            required bool fever,
            required bool cough,
            required bool diarrhea,
            Value<String?> notes = const Value.absent(),
            required bool followUpRequired,
            Value<double?> locationLat = const Value.absent(),
            Value<double?> locationLng = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<int> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VisitsTableCompanion.insert(
            id: id,
            familyId: familyId,
            visitDate: visitDate,
            healthStatus: healthStatus,
            fever: fever,
            cough: cough,
            diarrhea: diarrhea,
            notes: notes,
            followUpRequired: followUpRequired,
            locationLat: locationLat,
            locationLng: locationLng,
            photoPath: photoPath,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VisitsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VisitsTableTable,
    VisitsTableData,
    $$VisitsTableTableFilterComposer,
    $$VisitsTableTableOrderingComposer,
    $$VisitsTableTableAnnotationComposer,
    $$VisitsTableTableCreateCompanionBuilder,
    $$VisitsTableTableUpdateCompanionBuilder,
    (
      VisitsTableData,
      BaseReferences<_$AppDatabase, $VisitsTableTable, VisitsTableData>
    ),
    VisitsTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ReportsTableTableTableManager get reportsTable =>
      $$ReportsTableTableTableManager(_db, _db.reportsTable);
  $$FamiliesTableTableTableManager get familiesTable =>
      $$FamiliesTableTableTableManager(_db, _db.familiesTable);
  $$ChildrenTableTableTableManager get childrenTable =>
      $$ChildrenTableTableTableManager(_db, _db.childrenTable);
  $$GrowthMeasurementsTableTableTableManager get growthMeasurementsTable =>
      $$GrowthMeasurementsTableTableTableManager(
          _db, _db.growthMeasurementsTable);
  $$VaccinationsTableTableTableManager get vaccinationsTable =>
      $$VaccinationsTableTableTableManager(_db, _db.vaccinationsTable);
  $$VisitsTableTableTableManager get visitsTable =>
      $$VisitsTableTableTableManager(_db, _db.visitsTable);
}
