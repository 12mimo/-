// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sqlite_mobile.dart';

// ignore_for_file: type=lint
class $ChatMessagesTable extends ChatMessages
    with TableInfo<$ChatMessagesTable, ChatMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $ChatMessagesTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _isUserMeta = const VerificationMeta('isUser');
  @override
  late final GeneratedColumn<int> isUser = GeneratedColumn<int>(
      'is_user', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);

  @override
  List<GeneratedColumn> get $columns =>
      [id, isUser, timestamp, imagePath, content];

  @override
  String get aliasedName => _alias ?? actualTableName;

  @override
  String get actualTableName => $name;
  static const String $name = 'chat_messages';

  @override
  VerificationContext validateIntegrity(Insertable<ChatMessage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_user')) {
      context.handle(_isUserMeta,
          isUser.isAcceptableOrUnknown(data['is_user']!, _isUserMeta));
    } else if (isInserting) {
      context.missing(_isUserMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  ChatMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      isUser: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_user'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
    );
  }

  @override
  $ChatMessagesTable createAlias(String alias) {
    return $ChatMessagesTable(attachedDatabase, alias);
  }
}

class ChatMessage extends DataClass implements Insertable<ChatMessage> {
  final int id;
  final int isUser;
  final DateTime timestamp;
  final String? imagePath;
  final String content;

  const ChatMessage(
      {required this.id,
      required this.isUser,
      required this.timestamp,
      this.imagePath,
      required this.content});

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_user'] = Variable<int>(isUser);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['content'] = Variable<String>(content);
    return map;
  }

  ChatMessagesCompanion toCompanion(bool nullToAbsent) {
    return ChatMessagesCompanion(
      id: Value(id),
      isUser: Value(isUser),
      timestamp: Value(timestamp),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      content: Value(content),
    );
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessage(
      id: serializer.fromJson<int>(json['id']),
      isUser: serializer.fromJson<int>(json['isUser']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      content: serializer.fromJson<String>(json['content']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isUser': serializer.toJson<int>(isUser),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'imagePath': serializer.toJson<String?>(imagePath),
      'content': serializer.toJson<String>(content),
    };
  }

  ChatMessage copyWith(
          {int? id,
          int? isUser,
          DateTime? timestamp,
          Value<String?> imagePath = const Value.absent(),
          String? content}) =>
      ChatMessage(
        id: id ?? this.id,
        isUser: isUser ?? this.isUser,
        timestamp: timestamp ?? this.timestamp,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        content: content ?? this.content,
      );

  ChatMessage copyWithCompanion(ChatMessagesCompanion data) {
    return ChatMessage(
      id: data.id.present ? data.id.value : this.id,
      isUser: data.isUser.present ? data.isUser.value : this.isUser,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessage(')
          ..write('id: $id, ')
          ..write('isUser: $isUser, ')
          ..write('timestamp: $timestamp, ')
          ..write('imagePath: $imagePath, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, isUser, timestamp, imagePath, content);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessage &&
          other.id == this.id &&
          other.isUser == this.isUser &&
          other.timestamp == this.timestamp &&
          other.imagePath == this.imagePath &&
          other.content == this.content);
}

class ChatMessagesCompanion extends UpdateCompanion<ChatMessage> {
  final Value<int> id;
  final Value<int> isUser;
  final Value<DateTime> timestamp;
  final Value<String?> imagePath;
  final Value<String> content;

  const ChatMessagesCompanion({
    this.id = const Value.absent(),
    this.isUser = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.content = const Value.absent(),
  });

  ChatMessagesCompanion.insert({
    this.id = const Value.absent(),
    required int isUser,
    required DateTime timestamp,
    this.imagePath = const Value.absent(),
    required String content,
  })  : isUser = Value(isUser),
        timestamp = Value(timestamp),
        content = Value(content);

  static Insertable<ChatMessage> custom({
    Expression<int>? id,
    Expression<int>? isUser,
    Expression<DateTime>? timestamp,
    Expression<String>? imagePath,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isUser != null) 'is_user': isUser,
      if (timestamp != null) 'timestamp': timestamp,
      if (imagePath != null) 'image_path': imagePath,
      if (content != null) 'content': content,
    });
  }

  ChatMessagesCompanion copyWith(
      {Value<int>? id,
      Value<int>? isUser,
      Value<DateTime>? timestamp,
      Value<String?>? imagePath,
      Value<String>? content}) {
    return ChatMessagesCompanion(
      id: id ?? this.id,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      imagePath: imagePath ?? this.imagePath,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isUser.present) {
      map['is_user'] = Variable<int>(isUser.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesCompanion(')
          ..write('id: $id, ')
          ..write('isUser: $isUser, ')
          ..write('timestamp: $timestamp, ')
          ..write('imagePath: $imagePath, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

abstract class _$DatabaseHelper extends GeneratedDatabase {
  _$DatabaseHelper(QueryExecutor e) : super(e);

  $DatabaseHelperManager get managers => $DatabaseHelperManager(this);
  late final $ChatMessagesTable chatMessages = $ChatMessagesTable(this);

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [chatMessages];
}

typedef $$ChatMessagesTableCreateCompanionBuilder = ChatMessagesCompanion
    Function({
  Value<int> id,
  required int isUser,
  required DateTime timestamp,
  Value<String?> imagePath,
  required String content,
});
typedef $$ChatMessagesTableUpdateCompanionBuilder = ChatMessagesCompanion
    Function({
  Value<int> id,
  Value<int> isUser,
  Value<DateTime> timestamp,
  Value<String?> imagePath,
  Value<String> content,
});

class $$ChatMessagesTableFilterComposer
    extends Composer<_$DatabaseHelper, $ChatMessagesTable> {
  $$ChatMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isUser => $composableBuilder(
      column: $table.isUser, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));
}

class $$ChatMessagesTableOrderingComposer
    extends Composer<_$DatabaseHelper, $ChatMessagesTable> {
  $$ChatMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isUser => $composableBuilder(
      column: $table.isUser, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));
}

class $$ChatMessagesTableAnnotationComposer
    extends Composer<_$DatabaseHelper, $ChatMessagesTable> {
  $$ChatMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get isUser =>
      $composableBuilder(column: $table.isUser, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);
}

class $$ChatMessagesTableTableManager extends RootTableManager<
    _$DatabaseHelper,
    $ChatMessagesTable,
    ChatMessage,
    $$ChatMessagesTableFilterComposer,
    $$ChatMessagesTableOrderingComposer,
    $$ChatMessagesTableAnnotationComposer,
    $$ChatMessagesTableCreateCompanionBuilder,
    $$ChatMessagesTableUpdateCompanionBuilder,
    (
      ChatMessage,
      BaseReferences<_$DatabaseHelper, $ChatMessagesTable, ChatMessage>
    ),
    ChatMessage,
    PrefetchHooks Function()> {
  $$ChatMessagesTableTableManager(_$DatabaseHelper db, $ChatMessagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> isUser = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String> content = const Value.absent(),
          }) =>
              ChatMessagesCompanion(
            id: id,
            isUser: isUser,
            timestamp: timestamp,
            imagePath: imagePath,
            content: content,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int isUser,
            required DateTime timestamp,
            Value<String?> imagePath = const Value.absent(),
            required String content,
          }) =>
              ChatMessagesCompanion.insert(
            id: id,
            isUser: isUser,
            timestamp: timestamp,
            imagePath: imagePath,
            content: content,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChatMessagesTableProcessedTableManager = ProcessedTableManager<
    _$DatabaseHelper,
    $ChatMessagesTable,
    ChatMessage,
    $$ChatMessagesTableFilterComposer,
    $$ChatMessagesTableOrderingComposer,
    $$ChatMessagesTableAnnotationComposer,
    $$ChatMessagesTableCreateCompanionBuilder,
    $$ChatMessagesTableUpdateCompanionBuilder,
    (
      ChatMessage,
      BaseReferences<_$DatabaseHelper, $ChatMessagesTable, ChatMessage>
    ),
    ChatMessage,
    PrefetchHooks Function()>;

class $DatabaseHelperManager {
  final _$DatabaseHelper _db;

  $DatabaseHelperManager(this._db);

  $$ChatMessagesTableTableManager get chatMessages =>
      $$ChatMessagesTableTableManager(_db, _db.chatMessages);
}
