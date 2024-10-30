import 'sqlite_stub.dart';

class DatabaseHelper implements DatabaseHelperInterface {
  @override
  Future<int> insertMessage(ChatMessagesCompanion message) async {
    print("该功能在Web平台不可用。");
    return 0;
  }

  @override
  Future<bool> updateMessage(ChatMessagesCompanion message) async {
    print("该功能在Web平台不可用。");
    return false;
  }

  @override
  Future<int> deleteMessage(int messageId) async {
    print("该功能在Web平台不可用。");
    return 0;
  }

  @override
  Future<ChatMessage> queryMessage(int messageId) async {
    print("该功能在Web平台不可用。");
    return null;
  }

  @override
  Future<List<ChatMessage>> queryAllMessages() async {
    print("该功能在Web平台不可用。");
    return [];
  }
}
