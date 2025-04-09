// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $HistoryItemsTable extends HistoryItems
    with TableInfo<$HistoryItemsTable, HistoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentPositionMeta =
      const VerificationMeta('currentPosition');
  @override
  late final GeneratedColumn<String> currentPosition = GeneratedColumn<String>(
      'current_position', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _markersMeta =
      const VerificationMeta('markers');
  @override
  late final GeneratedColumn<String> markers = GeneratedColumn<String>(
      'markers', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, currentPosition, markers];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'history_items';
  @override
  VerificationContext validateIntegrity(Insertable<HistoryItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('current_position')) {
      context.handle(
          _currentPositionMeta,
          currentPosition.isAcceptableOrUnknown(
              data['current_position']!, _currentPositionMeta));
    } else if (isInserting) {
      context.missing(_currentPositionMeta);
    }
    if (data.containsKey('markers')) {
      context.handle(_markersMeta,
          markers.isAcceptableOrUnknown(data['markers']!, _markersMeta));
    } else if (isInserting) {
      context.missing(_markersMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoryItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      currentPosition: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}current_position'])!,
      markers: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}markers'])!,
    );
  }

  @override
  $HistoryItemsTable createAlias(String alias) {
    return $HistoryItemsTable(attachedDatabase, alias);
  }
}

class HistoryItem extends DataClass implements Insertable<HistoryItem> {
  final int id;
  final String title;
  final String currentPosition;
  final String markers;
  const HistoryItem(
      {required this.id,
      required this.title,
      required this.currentPosition,
      required this.markers});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['current_position'] = Variable<String>(currentPosition);
    map['markers'] = Variable<String>(markers);
    return map;
  }

  HistoryItemsCompanion toCompanion(bool nullToAbsent) {
    return HistoryItemsCompanion(
      id: Value(id),
      title: Value(title),
      currentPosition: Value(currentPosition),
      markers: Value(markers),
    );
  }

  factory HistoryItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoryItem(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      currentPosition: serializer.fromJson<String>(json['currentPosition']),
      markers: serializer.fromJson<String>(json['markers']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'currentPosition': serializer.toJson<String>(currentPosition),
      'markers': serializer.toJson<String>(markers),
    };
  }

  HistoryItem copyWith(
          {int? id, String? title, String? currentPosition, String? markers}) =>
      HistoryItem(
        id: id ?? this.id,
        title: title ?? this.title,
        currentPosition: currentPosition ?? this.currentPosition,
        markers: markers ?? this.markers,
      );
  HistoryItem copyWithCompanion(HistoryItemsCompanion data) {
    return HistoryItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      currentPosition: data.currentPosition.present
          ? data.currentPosition.value
          : this.currentPosition,
      markers: data.markers.present ? data.markers.value : this.markers,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistoryItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('currentPosition: $currentPosition, ')
          ..write('markers: $markers')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, currentPosition, markers);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.currentPosition == this.currentPosition &&
          other.markers == this.markers);
}

class HistoryItemsCompanion extends UpdateCompanion<HistoryItem> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> currentPosition;
  final Value<String> markers;
  const HistoryItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.currentPosition = const Value.absent(),
    this.markers = const Value.absent(),
  });
  HistoryItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String currentPosition,
    required String markers,
  })  : title = Value(title),
        currentPosition = Value(currentPosition),
        markers = Value(markers);
  static Insertable<HistoryItem> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? currentPosition,
    Expression<String>? markers,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (currentPosition != null) 'current_position': currentPosition,
      if (markers != null) 'markers': markers,
    });
  }

  HistoryItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? currentPosition,
      Value<String>? markers}) {
    return HistoryItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      currentPosition: currentPosition ?? this.currentPosition,
      markers: markers ?? this.markers,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (currentPosition.present) {
      map['current_position'] = Variable<String>(currentPosition.value);
    }
    if (markers.present) {
      map['markers'] = Variable<String>(markers.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('currentPosition: $currentPosition, ')
          ..write('markers: $markers')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HistoryItemsTable historyItems = $HistoryItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [historyItems];
}

typedef $$HistoryItemsTableCreateCompanionBuilder = HistoryItemsCompanion
    Function({
  Value<int> id,
  required String title,
  required String currentPosition,
  required String markers,
});
typedef $$HistoryItemsTableUpdateCompanionBuilder = HistoryItemsCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> currentPosition,
  Value<String> markers,
});

class $$HistoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $HistoryItemsTable> {
  $$HistoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentPosition => $composableBuilder(
      column: $table.currentPosition,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get markers => $composableBuilder(
      column: $table.markers, builder: (column) => ColumnFilters(column));
}

class $$HistoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $HistoryItemsTable> {
  $$HistoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentPosition => $composableBuilder(
      column: $table.currentPosition,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get markers => $composableBuilder(
      column: $table.markers, builder: (column) => ColumnOrderings(column));
}

class $$HistoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistoryItemsTable> {
  $$HistoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get currentPosition => $composableBuilder(
      column: $table.currentPosition, builder: (column) => column);

  GeneratedColumn<String> get markers =>
      $composableBuilder(column: $table.markers, builder: (column) => column);
}

class $$HistoryItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HistoryItemsTable,
    HistoryItem,
    $$HistoryItemsTableFilterComposer,
    $$HistoryItemsTableOrderingComposer,
    $$HistoryItemsTableAnnotationComposer,
    $$HistoryItemsTableCreateCompanionBuilder,
    $$HistoryItemsTableUpdateCompanionBuilder,
    (
      HistoryItem,
      BaseReferences<_$AppDatabase, $HistoryItemsTable, HistoryItem>
    ),
    HistoryItem,
    PrefetchHooks Function()> {
  $$HistoryItemsTableTableManager(_$AppDatabase db, $HistoryItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> currentPosition = const Value.absent(),
            Value<String> markers = const Value.absent(),
          }) =>
              HistoryItemsCompanion(
            id: id,
            title: title,
            currentPosition: currentPosition,
            markers: markers,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String currentPosition,
            required String markers,
          }) =>
              HistoryItemsCompanion.insert(
            id: id,
            title: title,
            currentPosition: currentPosition,
            markers: markers,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HistoryItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HistoryItemsTable,
    HistoryItem,
    $$HistoryItemsTableFilterComposer,
    $$HistoryItemsTableOrderingComposer,
    $$HistoryItemsTableAnnotationComposer,
    $$HistoryItemsTableCreateCompanionBuilder,
    $$HistoryItemsTableUpdateCompanionBuilder,
    (
      HistoryItem,
      BaseReferences<_$AppDatabase, $HistoryItemsTable, HistoryItem>
    ),
    HistoryItem,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HistoryItemsTableTableManager get historyItems =>
      $$HistoryItemsTableTableManager(_db, _db.historyItems);
}
