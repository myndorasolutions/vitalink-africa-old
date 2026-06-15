// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vitals_queue_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVitalsQueueItemCollection on Isar {
  IsarCollection<VitalsQueueItem> get vitalsQueueItems => this.collection();
}

const VitalsQueueItemSchema = CollectionSchema(
  name: r'VitalsQueueItem',
  id: -6011442031639328413,
  properties: {
    r'bloodGlucose': PropertySchema(
      id: 0,
      name: r'bloodGlucose',
      type: IsarType.double,
    ),
    r'capturedAt': PropertySchema(
      id: 1,
      name: r'capturedAt',
      type: IsarType.dateTime,
    ),
    r'diastolicBp': PropertySchema(
      id: 2,
      name: r'diastolicBp',
      type: IsarType.long,
    ),
    r'isSynced': PropertySchema(
      id: 3,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'patientId': PropertySchema(
      id: 4,
      name: r'patientId',
      type: IsarType.string,
    ),
    r'systolicBp': PropertySchema(
      id: 5,
      name: r'systolicBp',
      type: IsarType.long,
    )
  },
  estimateSize: _vitalsQueueItemEstimateSize,
  serialize: _vitalsQueueItemSerialize,
  deserialize: _vitalsQueueItemDeserialize,
  deserializeProp: _vitalsQueueItemDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _vitalsQueueItemGetId,
  getLinks: _vitalsQueueItemGetLinks,
  attach: _vitalsQueueItemAttach,
  version: '3.1.0+1',
);

int _vitalsQueueItemEstimateSize(
  VitalsQueueItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.patientId.length * 3;
  return bytesCount;
}

void _vitalsQueueItemSerialize(
  VitalsQueueItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.bloodGlucose);
  writer.writeDateTime(offsets[1], object.capturedAt);
  writer.writeLong(offsets[2], object.diastolicBp);
  writer.writeBool(offsets[3], object.isSynced);
  writer.writeString(offsets[4], object.patientId);
  writer.writeLong(offsets[5], object.systolicBp);
}

VitalsQueueItem _vitalsQueueItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VitalsQueueItem();
  object.bloodGlucose = reader.readDoubleOrNull(offsets[0]);
  object.capturedAt = reader.readDateTime(offsets[1]);
  object.diastolicBp = reader.readLongOrNull(offsets[2]);
  object.id = id;
  object.isSynced = reader.readBool(offsets[3]);
  object.patientId = reader.readString(offsets[4]);
  object.systolicBp = reader.readLongOrNull(offsets[5]);
  return object;
}

P _vitalsQueueItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _vitalsQueueItemGetId(VitalsQueueItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _vitalsQueueItemGetLinks(VitalsQueueItem object) {
  return [];
}

void _vitalsQueueItemAttach(
    IsarCollection<dynamic> col, Id id, VitalsQueueItem object) {
  object.id = id;
}

extension VitalsQueueItemQueryWhereSort
    on QueryBuilder<VitalsQueueItem, VitalsQueueItem, QWhere> {
  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VitalsQueueItemQueryWhere
    on QueryBuilder<VitalsQueueItem, VitalsQueueItem, QWhereClause> {
  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterWhereClause>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterWhereClause> idBetween(
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
}

extension VitalsQueueItemQueryFilter
    on QueryBuilder<VitalsQueueItem, VitalsQueueItem, QFilterCondition> {
  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      bloodGlucoseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bloodGlucose',
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      bloodGlucoseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bloodGlucose',
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      bloodGlucoseEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bloodGlucose',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      bloodGlucoseGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bloodGlucose',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      bloodGlucoseLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bloodGlucose',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      bloodGlucoseBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bloodGlucose',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      capturedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'capturedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      capturedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'capturedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      capturedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'capturedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      capturedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'capturedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      diastolicBpIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'diastolicBp',
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      diastolicBpIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'diastolicBp',
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      diastolicBpEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diastolicBp',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      isSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      patientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      patientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'patientId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      patientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'patientId',
        value: '',
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      patientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'patientId',
        value: '',
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      systolicBpIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'systolicBp',
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      systolicBpIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'systolicBp',
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
      systolicBpEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'systolicBp',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterFilterCondition>
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
}

extension VitalsQueueItemQueryObject
    on QueryBuilder<VitalsQueueItem, VitalsQueueItem, QFilterCondition> {}

extension VitalsQueueItemQueryLinks
    on QueryBuilder<VitalsQueueItem, VitalsQueueItem, QFilterCondition> {}

extension VitalsQueueItemQuerySortBy
    on QueryBuilder<VitalsQueueItem, VitalsQueueItem, QSortBy> {
  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      sortByBloodGlucose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodGlucose', Sort.asc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      sortByBloodGlucoseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodGlucose', Sort.desc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      sortByCapturedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capturedAt', Sort.asc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      sortByCapturedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capturedAt', Sort.desc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      sortByDiastolicBp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diastolicBp', Sort.asc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      sortByDiastolicBpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diastolicBp', Sort.desc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      sortByPatientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.asc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      sortByPatientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.desc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      sortBySystolicBp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systolicBp', Sort.asc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      sortBySystolicBpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systolicBp', Sort.desc);
    });
  }
}

extension VitalsQueueItemQuerySortThenBy
    on QueryBuilder<VitalsQueueItem, VitalsQueueItem, QSortThenBy> {
  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      thenByBloodGlucose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodGlucose', Sort.asc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      thenByBloodGlucoseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodGlucose', Sort.desc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      thenByCapturedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capturedAt', Sort.asc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      thenByCapturedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capturedAt', Sort.desc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      thenByDiastolicBp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diastolicBp', Sort.asc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      thenByDiastolicBpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diastolicBp', Sort.desc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      thenByPatientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.asc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      thenByPatientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.desc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      thenBySystolicBp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systolicBp', Sort.asc);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QAfterSortBy>
      thenBySystolicBpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systolicBp', Sort.desc);
    });
  }
}

extension VitalsQueueItemQueryWhereDistinct
    on QueryBuilder<VitalsQueueItem, VitalsQueueItem, QDistinct> {
  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QDistinct>
      distinctByBloodGlucose() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bloodGlucose');
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QDistinct>
      distinctByCapturedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'capturedAt');
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QDistinct>
      distinctByDiastolicBp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diastolicBp');
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QDistinct>
      distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QDistinct> distinctByPatientId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'patientId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VitalsQueueItem, VitalsQueueItem, QDistinct>
      distinctBySystolicBp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'systolicBp');
    });
  }
}

extension VitalsQueueItemQueryProperty
    on QueryBuilder<VitalsQueueItem, VitalsQueueItem, QQueryProperty> {
  QueryBuilder<VitalsQueueItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VitalsQueueItem, double?, QQueryOperations>
      bloodGlucoseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bloodGlucose');
    });
  }

  QueryBuilder<VitalsQueueItem, DateTime, QQueryOperations>
      capturedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'capturedAt');
    });
  }

  QueryBuilder<VitalsQueueItem, int?, QQueryOperations> diastolicBpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diastolicBp');
    });
  }

  QueryBuilder<VitalsQueueItem, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<VitalsQueueItem, String, QQueryOperations> patientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'patientId');
    });
  }

  QueryBuilder<VitalsQueueItem, int?, QQueryOperations> systolicBpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'systolicBp');
    });
  }
}
