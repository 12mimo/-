import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'sqlite.g.dart';

@DataClassName('ChatMessage')
class ChatMessages extends Table {
  IntColumn get id => integer().autoIncrement()(); // 主键字段
  IntColumn get isUser => integer()(); // 是否是用户发送

  DateTimeColumn get timestamp => dateTime()(); // 发送时间

  TextColumn get imagePath => text().nullable()(); // 图片地址

  TextColumn get content => text()(); // 发送以及回复内容
}

@DriftDatabase(tables: [ChatMessages])
class DatabaseHelper extends _$DatabaseHelper {
  DatabaseHelper() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insertMessage(ChatMessagesCompanion message) =>
      into(chatMessages).insert(message, mode: InsertMode.insertOrReplace);

  Future<bool> updateMessage(ChatMessagesCompanion message) =>
      update(chatMessages).replace(message);

  Future<int> deleteMessage(int messageId) =>
      (delete(chatMessages)..where((tbl) => tbl.id.equals(messageId))).go();

  Future<ChatMessage?> queryMessage(int messageId) =>
      (select(chatMessages)..where((tbl) => tbl.id.equals(messageId)))
          .getSingleOrNull();

  Future<List<ChatMessage>> queryAllMessages() => select(chatMessages).get();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'chat_database.sqlite'));
    return NativeDatabase(file);
  });
}
