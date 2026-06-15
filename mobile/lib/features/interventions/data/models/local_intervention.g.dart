// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_intervention.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalInterventionCollection on Isar {
  IsarCollection<LocalIntervention> get localInterventions => this.collection();
}

const LocalInterventionSchema = CollectionSchema(
  name: r'LocalIntervention',
  id: -2401707190421093751,
  properties: {
    r'aiModelVersion': PropertySchema(
      id: 0,
      name: r'aiModelVersion',
      type: IsarType.string,
    ),
    r'alertId': PropertySchema(
      id: 1,
      name: r'alertId',
      type: IsarType.string,
    ),
    r'checklist': PropertySchema(
      id: 2,
      name: r'checklist',
      type: IsarType.objectList,
      target: r'LocalChecklistItem',
    ),
    r'checklistMetrics': PropertySchema(
      id: 3,
      name: r'checklistMetrics',
      type: IsarType.object,
      target: r'LocalChecklistMetrics',
    ),
    r'completedAt': PropertySchema(
      id: 4,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'createdAt': PropertySchema(
      id: 5,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'diastolicBp': PropertySchema(
      id: 6,
      name: r'diastolicBp',
      type: IsarType.long,
    ),
    r'glucoseFasting': PropertySchema(
      id: 7,
      name: r'glucoseFasting',
      type: IsarType.double,
    ),
    r'glucoseRandom': PropertySchema(
      id: 8,
      name: r'glucoseRandom',
      type: IsarType.double,
    ),
    r'initiatedByUserId': PropertySchema(
      id: 9,
      name: r'initiatedByUserId',
      type: IsarType.string,
    ),
    r'localId': PropertySchema(
      id: 10,
      name: r'localId',
      type: IsarType.string,
    ),
    r'medicationTaken': PropertySchema(
      id: 11,
      name: r'medicationTaken',
      type: IsarType.bool,
    ),
    r'notes': PropertySchema(
      id: 12,
      name: r'notes',
      type: IsarType.string,
    ),
    r'path': PropertySchema(
      id: 13,
      name: r'path',
      type: IsarType.string,
    ),
    r'patientId': PropertySchema(
      id: 14,
      name: r'patientId',
      type: IsarType.string,
    ),
    r'riskTier': PropertySchema(
      id: 15,
      name: r'riskTier',
      type: IsarType.string,
      enumMap: _LocalInterventionriskTierEnumValueMap,
    ),
    r'serverId': PropertySchema(
      id: 16,
      name: r'serverId',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 17,
      name: r'status',
      type: IsarType.string,
      enumMap: _LocalInterventionstatusEnumValueMap,
    ),
    r'summary': PropertySchema(
      id: 18,
      name: r'summary',
      type: IsarType.string,
    ),
    r'symptoms': PropertySchema(
      id: 19,
      name: r'symptoms',
      type: IsarType.stringList,
    ),
    r'syncError': PropertySchema(
      id: 20,
      name: r'syncError',
      type: IsarType.string,
    ),
    r'syncStatus': PropertySchema(
      id: 21,
      name: r'syncStatus',
      type: IsarType.string,
      enumMap: _LocalInterventionsyncStatusEnumValueMap,
    ),
    r'syncedAt': PropertySchema(
      id: 22,
      name: r'syncedAt',
      type: IsarType.dateTime,
    ),
    r'systolicBp': PropertySchema(
      id: 23,
      name: r'systolicBp',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 24,
      name: r'title',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 25,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'vitalId': PropertySchema(
      id: 26,
      name: r'vitalId',
      type: IsarType.string,
    )
  },
  estimateSize: _localInterventionEstimateSize,
  serialize: _localInterventionSerialize,
  deserialize: _localInterventionDeserialize,
  deserializeProp: _localInterventionDeserializeProp,
  idName: r'id',
  indexes: {
    r'localId': IndexSchema(
      id: 1199848425898359622,
      name: r'localId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'localId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'patientId': IndexSchema(
      id: 403389457658259617,
      name: r'patientId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'patientId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'status': IndexSchema(
      id: -107785170620420283,
      name: r'status',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'status',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'riskTier': IndexSchema(
      id: -2445339766579290076,
      name: r'riskTier',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'riskTier',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'syncStatus': IndexSchema(
      id: 8239539375045684509,
      name: r'syncStatus',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'syncStatus',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'LocalChecklistItem': LocalChecklistItemSchema,
    r'LocalChecklistMetrics': LocalChecklistMetricsSchema
  },
  getId: _localInterventionGetId,
  getLinks: _localInterventionGetLinks,
  attach: _localInterventionAttach,
  version: '3.1.0+1',
);

int _localInterventionEstimateSize(
  LocalIntervention object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.aiModelVersion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.alertId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.checklist.length * 3;
  {
    final offsets = allOffsets[LocalChecklistItem]!;
    for (var i = 0; i < object.checklist.length; i++) {
      final value = object.checklist[i];
      bytesCount +=
          LocalChecklistItemSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.checklistMetrics;
    if (value != null) {
      bytesCount += 3 +
          LocalChecklistMetricsSchema.estimateSize(
              value, allOffsets[LocalChecklistMetrics]!, allOffsets);
    }
  }
  {
    final value = object.initiatedByUserId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.localId.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  bytesCount += 3 + object.path.length * 3;
  bytesCount += 3 + object.patientId.length * 3;
  bytesCount += 3 + object.riskTier.name.length * 3;
  {
    final value = object.serverId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.status.name.length * 3;
  bytesCount += 3 + object.summary.length * 3;
  bytesCount += 3 + object.symptoms.length * 3;
  {
    for (var i = 0; i < object.symptoms.length; i++) {
      final value = object.symptoms[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.syncError;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.syncStatus.name.length * 3;
  bytesCount += 3 + object.title.length * 3;
  {
    final value = object.vitalId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _localInterventionSerialize(
  LocalIntervention object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aiModelVersion);
  writer.writeString(offsets[1], object.alertId);
  writer.writeObjectList<LocalChecklistItem>(
    offsets[2],
    allOffsets,
    LocalChecklistItemSchema.serialize,
    object.checklist,
  );
  writer.writeObject<LocalChecklistMetrics>(
    offsets[3],
    allOffsets,
    LocalChecklistMetricsSchema.serialize,
    object.checklistMetrics,
  );
  writer.writeDateTime(offsets[4], object.completedAt);
  writer.writeDateTime(offsets[5], object.createdAt);
  writer.writeLong(offsets[6], object.diastolicBp);
  writer.writeDouble(offsets[7], object.glucoseFasting);
  writer.writeDouble(offsets[8], object.glucoseRandom);
  writer.writeString(offsets[9], object.initiatedByUserId);
  writer.writeString(offsets[10], object.localId);
  writer.writeBool(offsets[11], object.medicationTaken);
  writer.writeString(offsets[12], object.notes);
  writer.writeString(offsets[13], object.path);
  writer.writeString(offsets[14], object.patientId);
  writer.writeString(offsets[15], object.riskTier.name);
  writer.writeString(offsets[16], object.serverId);
  writer.writeString(offsets[17], object.status.name);
  writer.writeString(offsets[18], object.summary);
  writer.writeStringList(offsets[19], object.symptoms);
  writer.writeString(offsets[20], object.syncError);
  writer.writeString(offsets[21], object.syncStatus.name);
  writer.writeDateTime(offsets[22], object.syncedAt);
  writer.writeLong(offsets[23], object.systolicBp);
  writer.writeString(offsets[24], object.title);
  writer.writeDateTime(offsets[25], object.updatedAt);
  writer.writeString(offsets[26], object.vitalId);
}

LocalIntervention _localInterventionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalIntervention();
  object.aiModelVersion = reader.readStringOrNull(offsets[0]);
  object.alertId = reader.readStringOrNull(offsets[1]);
  object.checklist = reader.readObjectList<LocalChecklistItem>(
        offsets[2],
        LocalChecklistItemSchema.deserialize,
        allOffsets,
        LocalChecklistItem(),
      ) ??
      [];
  object.checklistMetrics = reader.readObjectOrNull<LocalChecklistMetrics>(
    offsets[3],
    LocalChecklistMetricsSchema.deserialize,
    allOffsets,
  );
  object.completedAt = reader.readDateTimeOrNull(offsets[4]);
  object.createdAt = reader.readDateTime(offsets[5]);
  object.diastolicBp = reader.readLongOrNull(offsets[6]);
  object.glucoseFasting = reader.readDoubleOrNull(offsets[7]);
  object.glucoseRandom = reader.readDoubleOrNull(offsets[8]);
  object.id = id;
  object.initiatedByUserId = reader.readStringOrNull(offsets[9]);
  object.localId = reader.readString(offsets[10]);
  object.medicationTaken = reader.readBoolOrNull(offsets[11]);
  object.notes = reader.readString(offsets[12]);
  object.path = reader.readString(offsets[13]);
  object.patientId = reader.readString(offsets[14]);
  object.riskTier = _LocalInterventionriskTierValueEnumMap[
          reader.readStringOrNull(offsets[15])] ??
      LocalRiskTier.low;
  object.serverId = reader.readStringOrNull(offsets[16]);
  object.status = _LocalInterventionstatusValueEnumMap[
          reader.readStringOrNull(offsets[17])] ??
      LocalInterventionStatus.draft;
  object.summary = reader.readString(offsets[18]);
  object.symptoms = reader.readStringList(offsets[19]) ?? [];
  object.syncError = reader.readStringOrNull(offsets[20]);
  object.syncStatus = _LocalInterventionsyncStatusValueEnumMap[
          reader.readStringOrNull(offsets[21])] ??
      SyncStatus.pending;
  object.syncedAt = reader.readDateTimeOrNull(offsets[22]);
  object.systolicBp = reader.readLongOrNull(offsets[23]);
  object.title = reader.readString(offsets[24]);
  object.updatedAt = reader.readDateTime(offsets[25]);
  object.vitalId = reader.readStringOrNull(offsets[26]);
  return object;
}

P _localInterventionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readObjectList<LocalChecklistItem>(
            offset,
            LocalChecklistItemSchema.deserialize,
            allOffsets,
            LocalChecklistItem(),
          ) ??
          []) as P;
    case 3:
      return (reader.readObjectOrNull<LocalChecklistMetrics>(
        offset,
        LocalChecklistMetricsSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readBoolOrNull(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (_LocalInterventionriskTierValueEnumMap[
              reader.readStringOrNull(offset)] ??
          LocalRiskTier.low) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (_LocalInterventionstatusValueEnumMap[
              reader.readStringOrNull(offset)] ??
          LocalInterventionStatus.draft) as P;
    case 18:
      return (reader.readString(offset)) as P;
    case 19:
      return (reader.readStringList(offset) ?? []) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (_LocalInterventionsyncStatusValueEnumMap[
              reader.readStringOrNull(offset)] ??
          SyncStatus.pending) as P;
    case 22:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 23:
      return (reader.readLongOrNull(offset)) as P;
    case 24:
      return (reader.readString(offset)) as P;
    case 25:
      return (reader.readDateTime(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _LocalInterventionriskTierEnumValueMap = {
  r'low': r'low',
  r'moderate': r'moderate',
  r'high': r'high',
  r'critical': r'critical',
};
const _LocalInterventionriskTierValueEnumMap = {
  r'low': LocalRiskTier.low,
  r'moderate': LocalRiskTier.moderate,
  r'high': LocalRiskTier.high,
  r'critical': LocalRiskTier.critical,
};
const _LocalInterventionstatusEnumValueMap = {
  r'draft': r'draft',
  r'pendingClinicianReview': r'pendingClinicianReview',
  r'active': r'active',
  r'completed': r'completed',
  r'cancelled': r'cancelled',
};
const _LocalInterventionstatusValueEnumMap = {
  r'draft': LocalInterventionStatus.draft,
  r'pendingClinicianReview': LocalInterventionStatus.pendingClinicianReview,
  r'active': LocalInterventionStatus.active,
  r'completed': LocalInterventionStatus.completed,
  r'cancelled': LocalInterventionStatus.cancelled,
};
const _LocalInterventionsyncStatusEnumValueMap = {
  r'pending': r'pending',
  r'synced': r'synced',
  r'failed': r'failed',
};
const _LocalInterventionsyncStatusValueEnumMap = {
  r'pending': SyncStatus.pending,
  r'synced': SyncStatus.synced,
  r'failed': SyncStatus.failed,
};

Id _localInterventionGetId(LocalIntervention object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _localInterventionGetLinks(
    LocalIntervention object) {
  return [];
}

void _localInterventionAttach(
    IsarCollection<dynamic> col, Id id, LocalIntervention object) {
  object.id = id;
}

extension LocalInterventionByIndex on IsarCollection<LocalIntervention> {
  Future<LocalIntervention?> getByLocalId(String localId) {
    return getByIndex(r'localId', [localId]);
  }

  LocalIntervention? getByLocalIdSync(String localId) {
    return getByIndexSync(r'localId', [localId]);
  }

  Future<bool> deleteByLocalId(String localId) {
    return deleteByIndex(r'localId', [localId]);
  }

  bool deleteByLocalIdSync(String localId) {
    return deleteByIndexSync(r'localId', [localId]);
  }

  Future<List<LocalIntervention?>> getAllByLocalId(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'localId', values);
  }

  List<LocalIntervention?> getAllByLocalIdSync(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'localId', values);
  }

  Future<int> deleteAllByLocalId(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'localId', values);
  }

  int deleteAllByLocalIdSync(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'localId', values);
  }

  Future<Id> putByLocalId(LocalIntervention object) {
    return putByIndex(r'localId', object);
  }

  Id putByLocalIdSync(LocalIntervention object, {bool saveLinks = true}) {
    return putByIndexSync(r'localId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByLocalId(List<LocalIntervention> objects) {
    return putAllByIndex(r'localId', objects);
  }

  List<Id> putAllByLocalIdSync(List<LocalIntervention> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'localId', objects, saveLinks: saveLinks);
  }
}

extension LocalInterventionQueryWhereSort
    on QueryBuilder<LocalIntervention, LocalIntervention, QWhere> {
  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhere>
      anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension LocalInterventionQueryWhere
    on QueryBuilder<LocalIntervention, LocalIntervention, QWhereClause> {
  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      localIdEqualTo(String localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'localId',
        value: [localId],
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      localIdNotEqualTo(String localId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localId',
              lower: [],
              upper: [localId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localId',
              lower: [localId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localId',
              lower: [localId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localId',
              lower: [],
              upper: [localId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      patientIdEqualTo(String patientId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'patientId',
        value: [patientId],
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      patientIdNotEqualTo(String patientId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'patientId',
              lower: [],
              upper: [patientId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'patientId',
              lower: [patientId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'patientId',
              lower: [patientId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'patientId',
              lower: [],
              upper: [patientId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      statusEqualTo(LocalInterventionStatus status) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'status',
        value: [status],
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      statusNotEqualTo(LocalInterventionStatus status) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      riskTierEqualTo(LocalRiskTier riskTier) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'riskTier',
        value: [riskTier],
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      riskTierNotEqualTo(LocalRiskTier riskTier) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'riskTier',
              lower: [],
              upper: [riskTier],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'riskTier',
              lower: [riskTier],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'riskTier',
              lower: [riskTier],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'riskTier',
              lower: [],
              upper: [riskTier],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      syncStatusEqualTo(SyncStatus syncStatus) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'syncStatus',
        value: [syncStatus],
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      syncStatusNotEqualTo(SyncStatus syncStatus) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'syncStatus',
              lower: [],
              upper: [syncStatus],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'syncStatus',
              lower: [syncStatus],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'syncStatus',
              lower: [syncStatus],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'syncStatus',
              lower: [],
              upper: [syncStatus],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterWhereClause>
      createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LocalInterventionQueryFilter
    on QueryBuilder<LocalIntervention, LocalIntervention, QFilterCondition> {
  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      aiModelVersionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aiModelVersion',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      aiModelVersionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aiModelVersion',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      aiModelVersionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiModelVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      aiModelVersionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiModelVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      aiModelVersionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiModelVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      aiModelVersionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiModelVersion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      aiModelVersionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aiModelVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      aiModelVersionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aiModelVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      aiModelVersionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aiModelVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      aiModelVersionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aiModelVersion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      aiModelVersionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiModelVersion',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      aiModelVersionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aiModelVersion',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      alertIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'alertId',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      alertIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'alertId',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      alertIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alertId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      alertIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'alertId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      alertIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'alertId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      alertIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'alertId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      alertIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'alertId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      alertIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'alertId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      alertIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'alertId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      alertIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'alertId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      alertIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alertId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      alertIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'alertId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      checklistLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checklist',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      checklistIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checklist',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      checklistIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checklist',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      checklistLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checklist',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      checklistLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checklist',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      checklistLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checklist',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      checklistMetricsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'checklistMetrics',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      checklistMetricsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'checklistMetrics',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      completedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      completedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      completedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      completedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      completedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      completedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      diastolicBpIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'diastolicBp',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      diastolicBpIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'diastolicBp',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      diastolicBpEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diastolicBp',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      diastolicBpGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diastolicBp',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      diastolicBpLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diastolicBp',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      diastolicBpBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diastolicBp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      glucoseFastingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'glucoseFasting',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      glucoseFastingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'glucoseFasting',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      glucoseFastingEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'glucoseFasting',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      glucoseFastingGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'glucoseFasting',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      glucoseFastingLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'glucoseFasting',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      glucoseFastingBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'glucoseFasting',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      glucoseRandomIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'glucoseRandom',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      glucoseRandomIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'glucoseRandom',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      glucoseRandomEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'glucoseRandom',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      glucoseRandomGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'glucoseRandom',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      glucoseRandomLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'glucoseRandom',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      glucoseRandomBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'glucoseRandom',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      initiatedByUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'initiatedByUserId',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      initiatedByUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'initiatedByUserId',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      initiatedByUserIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'initiatedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      initiatedByUserIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'initiatedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      initiatedByUserIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'initiatedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      initiatedByUserIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'initiatedByUserId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      initiatedByUserIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'initiatedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      initiatedByUserIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'initiatedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      initiatedByUserIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'initiatedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      initiatedByUserIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'initiatedByUserId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      initiatedByUserIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'initiatedByUserId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      initiatedByUserIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'initiatedByUserId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      localIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      localIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      localIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      localIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      localIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      localIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      localIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      localIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      localIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      localIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      medicationTakenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'medicationTaken',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      medicationTakenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'medicationTaken',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      medicationTakenEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'medicationTaken',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      notesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      notesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      notesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      notesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      pathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      pathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      pathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      pathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      pathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      pathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      pathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      pathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      patientIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      patientIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      patientIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      patientIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'patientId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      patientIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      patientIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      patientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      patientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'patientId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      patientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'patientId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      patientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'patientId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      riskTierEqualTo(
    LocalRiskTier value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'riskTier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      riskTierGreaterThan(
    LocalRiskTier value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'riskTier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      riskTierLessThan(
    LocalRiskTier value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'riskTier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      riskTierBetween(
    LocalRiskTier lower,
    LocalRiskTier upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'riskTier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      riskTierStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'riskTier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      riskTierEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'riskTier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      riskTierContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'riskTier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      riskTierMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'riskTier',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      riskTierIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'riskTier',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      riskTierIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'riskTier',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      serverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'serverId',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      serverIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'serverId',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      serverIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      serverIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      serverIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      serverIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serverId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      serverIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      serverIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      serverIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      serverIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serverId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      serverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      serverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serverId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      statusEqualTo(
    LocalInterventionStatus value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      statusGreaterThan(
    LocalInterventionStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      statusLessThan(
    LocalInterventionStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      statusBetween(
    LocalInterventionStatus lower,
    LocalInterventionStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      summaryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      summaryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      summaryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      summaryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'summary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      summaryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      summaryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      summaryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      summaryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'summary',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      summaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summary',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      summaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'summary',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'symptoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'symptoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'symptoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'symptoms',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'symptoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'symptoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'symptoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'symptoms',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'symptoms',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'symptoms',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'symptoms',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'symptoms',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'symptoms',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'symptoms',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'symptoms',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      symptomsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'symptoms',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncErrorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'syncError',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncErrorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'syncError',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncErrorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncErrorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncErrorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncErrorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncError',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncErrorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'syncError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncErrorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'syncError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncErrorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'syncError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncErrorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'syncError',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncErrorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncError',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncErrorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'syncError',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncStatusEqualTo(
    SyncStatus value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncStatusGreaterThan(
    SyncStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncStatusLessThan(
    SyncStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncStatusBetween(
    SyncStatus lower,
    SyncStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'syncStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'syncStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'syncedAt',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'syncedAt',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      syncedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      systolicBpIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'systolicBp',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      systolicBpIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'systolicBp',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      systolicBpEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'systolicBp',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      systolicBpGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'systolicBp',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      systolicBpLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'systolicBp',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      systolicBpBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'systolicBp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      vitalIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vitalId',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      vitalIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vitalId',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      vitalIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vitalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      vitalIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vitalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      vitalIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vitalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      vitalIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vitalId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      vitalIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vitalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      vitalIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vitalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      vitalIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vitalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      vitalIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vitalId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      vitalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vitalId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      vitalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vitalId',
        value: '',
      ));
    });
  }
}

extension LocalInterventionQueryObject
    on QueryBuilder<LocalIntervention, LocalIntervention, QFilterCondition> {
  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      checklistElement(FilterQuery<LocalChecklistItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'checklist');
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterFilterCondition>
      checklistMetrics(FilterQuery<LocalChecklistMetrics> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'checklistMetrics');
    });
  }
}

extension LocalInterventionQueryLinks
    on QueryBuilder<LocalIntervention, LocalIntervention, QFilterCondition> {}

extension LocalInterventionQuerySortBy
    on QueryBuilder<LocalIntervention, LocalIntervention, QSortBy> {
  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByAiModelVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiModelVersion', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByAiModelVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiModelVersion', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByAlertId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alertId', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByAlertIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alertId', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByDiastolicBp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diastolicBp', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByDiastolicBpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diastolicBp', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByGlucoseFasting() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glucoseFasting', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByGlucoseFastingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glucoseFasting', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByGlucoseRandom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glucoseRandom', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByGlucoseRandomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glucoseRandom', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByInitiatedByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initiatedByUserId', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByInitiatedByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initiatedByUserId', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByMedicationTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationTaken', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByMedicationTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationTaken', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByPatientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByPatientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByRiskTier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riskTier', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByRiskTierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riskTier', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByServerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByServerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortBySyncError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncError', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortBySyncErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncError', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortBySyncedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortBySystolicBp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systolicBp', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortBySystolicBpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systolicBp', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByVitalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vitalId', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      sortByVitalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vitalId', Sort.desc);
    });
  }
}

extension LocalInterventionQuerySortThenBy
    on QueryBuilder<LocalIntervention, LocalIntervention, QSortThenBy> {
  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByAiModelVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiModelVersion', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByAiModelVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiModelVersion', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByAlertId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alertId', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByAlertIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alertId', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByDiastolicBp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diastolicBp', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByDiastolicBpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diastolicBp', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByGlucoseFasting() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glucoseFasting', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByGlucoseFastingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glucoseFasting', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByGlucoseRandom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glucoseRandom', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByGlucoseRandomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glucoseRandom', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByInitiatedByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initiatedByUserId', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByInitiatedByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initiatedByUserId', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByMedicationTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationTaken', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByMedicationTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationTaken', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByPatientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByPatientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByRiskTier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riskTier', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByRiskTierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riskTier', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByServerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByServerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenBySyncError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncError', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenBySyncErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncError', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenBySyncedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenBySystolicBp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systolicBp', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenBySystolicBpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systolicBp', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByVitalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vitalId', Sort.asc);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QAfterSortBy>
      thenByVitalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vitalId', Sort.desc);
    });
  }
}

extension LocalInterventionQueryWhereDistinct
    on QueryBuilder<LocalIntervention, LocalIntervention, QDistinct> {
  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByAiModelVersion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiModelVersion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByAlertId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alertId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByDiastolicBp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diastolicBp');
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByGlucoseFasting() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'glucoseFasting');
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByGlucoseRandom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'glucoseRandom');
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByInitiatedByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'initiatedByUserId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByLocalId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByMedicationTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'medicationTaken');
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct> distinctByPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByPatientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'patientId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByRiskTier({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'riskTier', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serverId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctBySummary({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'summary', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctBySymptoms() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'symptoms');
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctBySyncError({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncError', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncedAt');
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctBySystolicBp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'systolicBp');
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<LocalIntervention, LocalIntervention, QDistinct>
      distinctByVitalId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vitalId', caseSensitive: caseSensitive);
    });
  }
}

extension LocalInterventionQueryProperty
    on QueryBuilder<LocalIntervention, LocalIntervention, QQueryProperty> {
  QueryBuilder<LocalIntervention, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocalIntervention, String?, QQueryOperations>
      aiModelVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiModelVersion');
    });
  }

  QueryBuilder<LocalIntervention, String?, QQueryOperations> alertIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alertId');
    });
  }

  QueryBuilder<LocalIntervention, List<LocalChecklistItem>, QQueryOperations>
      checklistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checklist');
    });
  }

  QueryBuilder<LocalIntervention, LocalChecklistMetrics?, QQueryOperations>
      checklistMetricsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checklistMetrics');
    });
  }

  QueryBuilder<LocalIntervention, DateTime?, QQueryOperations>
      completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<LocalIntervention, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<LocalIntervention, int?, QQueryOperations>
      diastolicBpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diastolicBp');
    });
  }

  QueryBuilder<LocalIntervention, double?, QQueryOperations>
      glucoseFastingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'glucoseFasting');
    });
  }

  QueryBuilder<LocalIntervention, double?, QQueryOperations>
      glucoseRandomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'glucoseRandom');
    });
  }

  QueryBuilder<LocalIntervention, String?, QQueryOperations>
      initiatedByUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'initiatedByUserId');
    });
  }

  QueryBuilder<LocalIntervention, String, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<LocalIntervention, bool?, QQueryOperations>
      medicationTakenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medicationTaken');
    });
  }

  QueryBuilder<LocalIntervention, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<LocalIntervention, String, QQueryOperations> pathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'path');
    });
  }

  QueryBuilder<LocalIntervention, String, QQueryOperations>
      patientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'patientId');
    });
  }

  QueryBuilder<LocalIntervention, LocalRiskTier, QQueryOperations>
      riskTierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'riskTier');
    });
  }

  QueryBuilder<LocalIntervention, String?, QQueryOperations>
      serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serverId');
    });
  }

  QueryBuilder<LocalIntervention, LocalInterventionStatus, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<LocalIntervention, String, QQueryOperations> summaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'summary');
    });
  }

  QueryBuilder<LocalIntervention, List<String>, QQueryOperations>
      symptomsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'symptoms');
    });
  }

  QueryBuilder<LocalIntervention, String?, QQueryOperations>
      syncErrorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncError');
    });
  }

  QueryBuilder<LocalIntervention, SyncStatus, QQueryOperations>
      syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }

  QueryBuilder<LocalIntervention, DateTime?, QQueryOperations>
      syncedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncedAt');
    });
  }

  QueryBuilder<LocalIntervention, int?, QQueryOperations> systolicBpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'systolicBp');
    });
  }

  QueryBuilder<LocalIntervention, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<LocalIntervention, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<LocalIntervention, String?, QQueryOperations> vitalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vitalId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const LocalChecklistItemSchema = Schema(
  name: r'LocalChecklistItem',
  id: 5019117769208262407,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'completed': PropertySchema(
      id: 1,
      name: r'completed',
      type: IsarType.bool,
    ),
    r'jnc8Reference': PropertySchema(
      id: 2,
      name: r'jnc8Reference',
      type: IsarType.string,
    ),
    r'key': PropertySchema(
      id: 3,
      name: r'key',
      type: IsarType.string,
    ),
    r'label': PropertySchema(
      id: 4,
      name: r'label',
      type: IsarType.string,
    ),
    r'mandatory': PropertySchema(
      id: 5,
      name: r'mandatory',
      type: IsarType.bool,
    ),
    r'rationale': PropertySchema(
      id: 6,
      name: r'rationale',
      type: IsarType.string,
    )
  },
  estimateSize: _localChecklistItemEstimateSize,
  serialize: _localChecklistItemSerialize,
  deserialize: _localChecklistItemDeserialize,
  deserializeProp: _localChecklistItemDeserializeProp,
);

int _localChecklistItemEstimateSize(
  LocalChecklistItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.jnc8Reference.length * 3;
  bytesCount += 3 + object.key.length * 3;
  bytesCount += 3 + object.label.length * 3;
  bytesCount += 3 + object.rationale.length * 3;
  return bytesCount;
}

void _localChecklistItemSerialize(
  LocalChecklistItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeBool(offsets[1], object.completed);
  writer.writeString(offsets[2], object.jnc8Reference);
  writer.writeString(offsets[3], object.key);
  writer.writeString(offsets[4], object.label);
  writer.writeBool(offsets[5], object.mandatory);
  writer.writeString(offsets[6], object.rationale);
}

LocalChecklistItem _localChecklistItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalChecklistItem();
  object.category = reader.readString(offsets[0]);
  object.completed = reader.readBool(offsets[1]);
  object.jnc8Reference = reader.readString(offsets[2]);
  object.key = reader.readString(offsets[3]);
  object.label = reader.readString(offsets[4]);
  object.mandatory = reader.readBool(offsets[5]);
  object.rationale = reader.readString(offsets[6]);
  return object;
}

P _localChecklistItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension LocalChecklistItemQueryFilter
    on QueryBuilder<LocalChecklistItem, LocalChecklistItem, QFilterCondition> {
  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      completedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completed',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      jnc8ReferenceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jnc8Reference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      jnc8ReferenceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jnc8Reference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      jnc8ReferenceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jnc8Reference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      jnc8ReferenceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jnc8Reference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      jnc8ReferenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'jnc8Reference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      jnc8ReferenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'jnc8Reference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      jnc8ReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'jnc8Reference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      jnc8ReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'jnc8Reference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      jnc8ReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jnc8Reference',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      jnc8ReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'jnc8Reference',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      keyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      keyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      keyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      keyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'key',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      keyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      keyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      keyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      keyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'key',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      labelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      labelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      labelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      labelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'label',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      labelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      labelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      mandatoryEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mandatory',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      rationaleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rationale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      rationaleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rationale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      rationaleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rationale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      rationaleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rationale',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      rationaleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rationale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      rationaleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rationale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      rationaleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rationale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      rationaleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rationale',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      rationaleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rationale',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistItem, LocalChecklistItem, QAfterFilterCondition>
      rationaleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rationale',
        value: '',
      ));
    });
  }
}

extension LocalChecklistItemQueryObject
    on QueryBuilder<LocalChecklistItem, LocalChecklistItem, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const LocalChecklistMetricsSchema = Schema(
  name: r'LocalChecklistMetrics',
  id: 4517015844557219020,
  properties: {
    r'compilationVersion': PropertySchema(
      id: 0,
      name: r'compilationVersion',
      type: IsarType.string,
    ),
    r'compiledAt': PropertySchema(
      id: 1,
      name: r'compiledAt',
      type: IsarType.string,
    ),
    r'completedItems': PropertySchema(
      id: 2,
      name: r'completedItems',
      type: IsarType.long,
    ),
    r'completionPct': PropertySchema(
      id: 3,
      name: r'completionPct',
      type: IsarType.long,
    ),
    r'jnc8BpStage': PropertySchema(
      id: 4,
      name: r'jnc8BpStage',
      type: IsarType.string,
    ),
    r'mandatoryItems': PropertySchema(
      id: 5,
      name: r'mandatoryItems',
      type: IsarType.long,
    ),
    r'riskTier': PropertySchema(
      id: 6,
      name: r'riskTier',
      type: IsarType.string,
      enumMap: _LocalChecklistMetricsriskTierEnumValueMap,
    ),
    r'totalItems': PropertySchema(
      id: 7,
      name: r'totalItems',
      type: IsarType.long,
    )
  },
  estimateSize: _localChecklistMetricsEstimateSize,
  serialize: _localChecklistMetricsSerialize,
  deserialize: _localChecklistMetricsDeserialize,
  deserializeProp: _localChecklistMetricsDeserializeProp,
);

int _localChecklistMetricsEstimateSize(
  LocalChecklistMetrics object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.compilationVersion.length * 3;
  bytesCount += 3 + object.compiledAt.length * 3;
  {
    final value = object.jnc8BpStage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.riskTier.name.length * 3;
  return bytesCount;
}

void _localChecklistMetricsSerialize(
  LocalChecklistMetrics object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.compilationVersion);
  writer.writeString(offsets[1], object.compiledAt);
  writer.writeLong(offsets[2], object.completedItems);
  writer.writeLong(offsets[3], object.completionPct);
  writer.writeString(offsets[4], object.jnc8BpStage);
  writer.writeLong(offsets[5], object.mandatoryItems);
  writer.writeString(offsets[6], object.riskTier.name);
  writer.writeLong(offsets[7], object.totalItems);
}

LocalChecklistMetrics _localChecklistMetricsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalChecklistMetrics();
  object.compilationVersion = reader.readString(offsets[0]);
  object.compiledAt = reader.readString(offsets[1]);
  object.completedItems = reader.readLong(offsets[2]);
  object.completionPct = reader.readLong(offsets[3]);
  object.jnc8BpStage = reader.readStringOrNull(offsets[4]);
  object.mandatoryItems = reader.readLong(offsets[5]);
  object.riskTier = _LocalChecklistMetricsriskTierValueEnumMap[
          reader.readStringOrNull(offsets[6])] ??
      LocalRiskTier.low;
  object.totalItems = reader.readLong(offsets[7]);
  return object;
}

P _localChecklistMetricsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (_LocalChecklistMetricsriskTierValueEnumMap[
              reader.readStringOrNull(offset)] ??
          LocalRiskTier.low) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _LocalChecklistMetricsriskTierEnumValueMap = {
  r'low': r'low',
  r'moderate': r'moderate',
  r'high': r'high',
  r'critical': r'critical',
};
const _LocalChecklistMetricsriskTierValueEnumMap = {
  r'low': LocalRiskTier.low,
  r'moderate': LocalRiskTier.moderate,
  r'high': LocalRiskTier.high,
  r'critical': LocalRiskTier.critical,
};

extension LocalChecklistMetricsQueryFilter on QueryBuilder<
    LocalChecklistMetrics, LocalChecklistMetrics, QFilterCondition> {
  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compilationVersionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'compilationVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compilationVersionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'compilationVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compilationVersionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'compilationVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compilationVersionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'compilationVersion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compilationVersionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'compilationVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compilationVersionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'compilationVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
          QAfterFilterCondition>
      compilationVersionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'compilationVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
          QAfterFilterCondition>
      compilationVersionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'compilationVersion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compilationVersionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'compilationVersion',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compilationVersionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'compilationVersion',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compiledAtEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'compiledAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compiledAtGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'compiledAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compiledAtLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'compiledAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compiledAtBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'compiledAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compiledAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'compiledAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compiledAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'compiledAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
          QAfterFilterCondition>
      compiledAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'compiledAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
          QAfterFilterCondition>
      compiledAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'compiledAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compiledAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'compiledAt',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> compiledAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'compiledAt',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> completedItemsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedItems',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> completedItemsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedItems',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> completedItemsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedItems',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> completedItemsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedItems',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> completionPctEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completionPct',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> completionPctGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completionPct',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> completionPctLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completionPct',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> completionPctBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completionPct',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> jnc8BpStageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'jnc8BpStage',
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> jnc8BpStageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'jnc8BpStage',
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> jnc8BpStageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jnc8BpStage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> jnc8BpStageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jnc8BpStage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> jnc8BpStageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jnc8BpStage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> jnc8BpStageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jnc8BpStage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> jnc8BpStageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'jnc8BpStage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> jnc8BpStageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'jnc8BpStage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
          QAfterFilterCondition>
      jnc8BpStageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'jnc8BpStage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
          QAfterFilterCondition>
      jnc8BpStageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'jnc8BpStage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> jnc8BpStageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jnc8BpStage',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> jnc8BpStageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'jnc8BpStage',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> mandatoryItemsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mandatoryItems',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> mandatoryItemsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mandatoryItems',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> mandatoryItemsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mandatoryItems',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> mandatoryItemsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mandatoryItems',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> riskTierEqualTo(
    LocalRiskTier value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'riskTier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> riskTierGreaterThan(
    LocalRiskTier value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'riskTier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> riskTierLessThan(
    LocalRiskTier value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'riskTier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> riskTierBetween(
    LocalRiskTier lower,
    LocalRiskTier upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'riskTier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> riskTierStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'riskTier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> riskTierEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'riskTier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
          QAfterFilterCondition>
      riskTierContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'riskTier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
          QAfterFilterCondition>
      riskTierMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'riskTier',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> riskTierIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'riskTier',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> riskTierIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'riskTier',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> totalItemsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalItems',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> totalItemsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalItems',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> totalItemsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalItems',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalChecklistMetrics, LocalChecklistMetrics,
      QAfterFilterCondition> totalItemsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalItems',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LocalChecklistMetricsQueryObject on QueryBuilder<
    LocalChecklistMetrics, LocalChecklistMetrics, QFilterCondition> {}
