// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_value.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTabValueCollection on Isar {
  IsarCollection<TabValue> get tabValues => this.collection();
}

const TabValueSchema = CollectionSchema(
  name: r'TabValue',
  id: -6815589332940558115,
  properties: {
    r'listTabIndex': PropertySchema(
      id: 0,
      name: r'listTabIndex',
      type: IsarType.long,
    ),
    r'tabIndex': PropertySchema(
      id: 1,
      name: r'tabIndex',
      type: IsarType.long,
    )
  },
  estimateSize: _tabValueEstimateSize,
  serialize: _tabValueSerialize,
  deserialize: _tabValueDeserialize,
  deserializeProp: _tabValueDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _tabValueGetId,
  getLinks: _tabValueGetLinks,
  attach: _tabValueAttach,
  version: '3.1.0+1',
);

int _tabValueEstimateSize(
  TabValue object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _tabValueSerialize(
  TabValue object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.listTabIndex);
  writer.writeLong(offsets[1], object.tabIndex);
}

TabValue _tabValueDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TabValue();
  object.id = id;
  object.listTabIndex = reader.readLongOrNull(offsets[0]);
  object.tabIndex = reader.readLongOrNull(offsets[1]);
  return object;
}

P _tabValueDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tabValueGetId(TabValue object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tabValueGetLinks(TabValue object) {
  return [];
}

void _tabValueAttach(IsarCollection<dynamic> col, Id id, TabValue object) {
  object.id = id;
}

extension TabValueQueryWhereSort on QueryBuilder<TabValue, TabValue, QWhere> {
  QueryBuilder<TabValue, TabValue, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TabValueQueryWhere on QueryBuilder<TabValue, TabValue, QWhereClause> {
  QueryBuilder<TabValue, TabValue, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<TabValue, TabValue, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterWhereClause> idBetween(
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

extension TabValueQueryFilter
    on QueryBuilder<TabValue, TabValue, QFilterCondition> {
  QueryBuilder<TabValue, TabValue, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition> listTabIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'listTabIndex',
      ));
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition>
      listTabIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'listTabIndex',
      ));
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition> listTabIndexEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listTabIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition>
      listTabIndexGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'listTabIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition> listTabIndexLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'listTabIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition> listTabIndexBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'listTabIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition> tabIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tabIndex',
      ));
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition> tabIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tabIndex',
      ));
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition> tabIndexEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tabIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition> tabIndexGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tabIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition> tabIndexLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tabIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterFilterCondition> tabIndexBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tabIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TabValueQueryObject
    on QueryBuilder<TabValue, TabValue, QFilterCondition> {}

extension TabValueQueryLinks
    on QueryBuilder<TabValue, TabValue, QFilterCondition> {}

extension TabValueQuerySortBy on QueryBuilder<TabValue, TabValue, QSortBy> {
  QueryBuilder<TabValue, TabValue, QAfterSortBy> sortByListTabIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listTabIndex', Sort.asc);
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterSortBy> sortByListTabIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listTabIndex', Sort.desc);
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterSortBy> sortByTabIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabIndex', Sort.asc);
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterSortBy> sortByTabIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabIndex', Sort.desc);
    });
  }
}

extension TabValueQuerySortThenBy
    on QueryBuilder<TabValue, TabValue, QSortThenBy> {
  QueryBuilder<TabValue, TabValue, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterSortBy> thenByListTabIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listTabIndex', Sort.asc);
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterSortBy> thenByListTabIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listTabIndex', Sort.desc);
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterSortBy> thenByTabIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabIndex', Sort.asc);
    });
  }

  QueryBuilder<TabValue, TabValue, QAfterSortBy> thenByTabIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabIndex', Sort.desc);
    });
  }
}

extension TabValueQueryWhereDistinct
    on QueryBuilder<TabValue, TabValue, QDistinct> {
  QueryBuilder<TabValue, TabValue, QDistinct> distinctByListTabIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listTabIndex');
    });
  }

  QueryBuilder<TabValue, TabValue, QDistinct> distinctByTabIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tabIndex');
    });
  }
}

extension TabValueQueryProperty
    on QueryBuilder<TabValue, TabValue, QQueryProperty> {
  QueryBuilder<TabValue, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TabValue, int?, QQueryOperations> listTabIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listTabIndex');
    });
  }

  QueryBuilder<TabValue, int?, QQueryOperations> tabIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tabIndex');
    });
  }
}
