// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_task.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalTaskCollection on Isar {
  IsarCollection<LocalTask> get localTasks => this.collection();
}

const LocalTaskSchema = CollectionSchema(
  name: r'LocalTask',
  id: -2302952909969641796,
  properties: {
    r'check': PropertySchema(
      id: 0,
      name: r'check',
      type: IsarType.bool,
    ),
    r'created': PropertySchema(
      id: 1,
      name: r'created',
      type: IsarType.dateTime,
    ),
    r'task': PropertySchema(
      id: 2,
      name: r'task',
      type: IsarType.string,
    ),
    r'updated': PropertySchema(
      id: 3,
      name: r'updated',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _localTaskEstimateSize,
  serialize: _localTaskSerialize,
  deserialize: _localTaskDeserialize,
  deserializeProp: _localTaskDeserializeProp,
  idName: r'id',
  indexes: {
    r'created': IndexSchema(
      id: 9089682803336859617,
      name: r'created',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'created',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _localTaskGetId,
  getLinks: _localTaskGetLinks,
  attach: _localTaskAttach,
  version: '3.1.0+1',
);

int _localTaskEstimateSize(
  LocalTask object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.task;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _localTaskSerialize(
  LocalTask object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.check);
  writer.writeDateTime(offsets[1], object.created);
  writer.writeString(offsets[2], object.task);
  writer.writeDateTime(offsets[3], object.updated);
}

LocalTask _localTaskDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalTask();
  object.check = reader.readBoolOrNull(offsets[0]);
  object.created = reader.readDateTimeOrNull(offsets[1]);
  object.id = id;
  object.task = reader.readStringOrNull(offsets[2]);
  object.updated = reader.readDateTimeOrNull(offsets[3]);
  return object;
}

P _localTaskDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _localTaskGetId(LocalTask object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _localTaskGetLinks(LocalTask object) {
  return [];
}

void _localTaskAttach(IsarCollection<dynamic> col, Id id, LocalTask object) {
  object.id = id;
}

extension LocalTaskQueryWhereSort
    on QueryBuilder<LocalTask, LocalTask, QWhere> {
  QueryBuilder<LocalTask, LocalTask, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterWhere> anyCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'created'),
      );
    });
  }
}

extension LocalTaskQueryWhere
    on QueryBuilder<LocalTask, LocalTask, QWhereClause> {
  QueryBuilder<LocalTask, LocalTask, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<LocalTask, LocalTask, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterWhereClause> idBetween(
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

  QueryBuilder<LocalTask, LocalTask, QAfterWhereClause> createdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'created',
        value: [null],
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterWhereClause> createdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'created',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterWhereClause> createdEqualTo(
      DateTime? created) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'created',
        value: [created],
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterWhereClause> createdNotEqualTo(
      DateTime? created) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'created',
              lower: [],
              upper: [created],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'created',
              lower: [created],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'created',
              lower: [created],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'created',
              lower: [],
              upper: [created],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterWhereClause> createdGreaterThan(
    DateTime? created, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'created',
        lower: [created],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterWhereClause> createdLessThan(
    DateTime? created, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'created',
        lower: [],
        upper: [created],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterWhereClause> createdBetween(
    DateTime? lowerCreated,
    DateTime? upperCreated, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'created',
        lower: [lowerCreated],
        includeLower: includeLower,
        upper: [upperCreated],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LocalTaskQueryFilter
    on QueryBuilder<LocalTask, LocalTask, QFilterCondition> {
  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> checkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'check',
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> checkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'check',
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> checkEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'check',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> createdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'created',
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> createdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'created',
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> createdEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> createdGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> createdLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> createdBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'created',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> idGreaterThan(
    Id? value, {
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

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> idLessThan(
    Id? value, {
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

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> taskIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'task',
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> taskIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'task',
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> taskEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'task',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> taskGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'task',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> taskLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'task',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> taskBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'task',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> taskStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'task',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> taskEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'task',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> taskContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'task',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> taskMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'task',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> taskIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'task',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> taskIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'task',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> updatedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updated',
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> updatedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updated',
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> updatedEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updated',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> updatedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updated',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> updatedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updated',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterFilterCondition> updatedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LocalTaskQueryObject
    on QueryBuilder<LocalTask, LocalTask, QFilterCondition> {}

extension LocalTaskQueryLinks
    on QueryBuilder<LocalTask, LocalTask, QFilterCondition> {}

extension LocalTaskQuerySortBy on QueryBuilder<LocalTask, LocalTask, QSortBy> {
  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> sortByCheck() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'check', Sort.asc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> sortByCheckDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'check', Sort.desc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> sortByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.asc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> sortByCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.desc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> sortByTask() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'task', Sort.asc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> sortByTaskDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'task', Sort.desc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> sortByUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updated', Sort.asc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> sortByUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updated', Sort.desc);
    });
  }
}

extension LocalTaskQuerySortThenBy
    on QueryBuilder<LocalTask, LocalTask, QSortThenBy> {
  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> thenByCheck() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'check', Sort.asc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> thenByCheckDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'check', Sort.desc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> thenByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.asc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> thenByCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.desc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> thenByTask() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'task', Sort.asc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> thenByTaskDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'task', Sort.desc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> thenByUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updated', Sort.asc);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QAfterSortBy> thenByUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updated', Sort.desc);
    });
  }
}

extension LocalTaskQueryWhereDistinct
    on QueryBuilder<LocalTask, LocalTask, QDistinct> {
  QueryBuilder<LocalTask, LocalTask, QDistinct> distinctByCheck() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'check');
    });
  }

  QueryBuilder<LocalTask, LocalTask, QDistinct> distinctByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'created');
    });
  }

  QueryBuilder<LocalTask, LocalTask, QDistinct> distinctByTask(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'task', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalTask, LocalTask, QDistinct> distinctByUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updated');
    });
  }
}

extension LocalTaskQueryProperty
    on QueryBuilder<LocalTask, LocalTask, QQueryProperty> {
  QueryBuilder<LocalTask, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocalTask, bool?, QQueryOperations> checkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'check');
    });
  }

  QueryBuilder<LocalTask, DateTime?, QQueryOperations> createdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'created');
    });
  }

  QueryBuilder<LocalTask, String?, QQueryOperations> taskProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'task');
    });
  }

  QueryBuilder<LocalTask, DateTime?, QQueryOperations> updatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updated');
    });
  }
}
