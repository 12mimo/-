class ChatMessage {
  final int id;
  final int isUser;
  final DateTime timestamp;
  final String imagePath;
  final String content;

  ChatMessage(
      { this.id,
       this.isUser,
       this.timestamp,
      this.imagePath,
       this.content});
}

class ChatMessagesCompanion {
  final dynamic id;
  final dynamic isUser;
  final dynamic timestamp;
  final dynamic imagePath;
  final dynamic content;

  ChatMessagesCompanion(
      {this.id, this.isUser, this.timestamp, this.imagePath, this.content});
}

// 一个空的数据库助手类，用于 Web 环境
abstract class DatabaseHelperInterface {
  Future<int> insertMessage(ChatMessagesCompanion message);

  Future<bool> updateMessage(ChatMessagesCompanion message);

  Future<int> deleteMessage(int messageId);

  Future<ChatMessage> queryMessage(int messageId);

  Future<List<ChatMessage>> queryAllMessages();
}
