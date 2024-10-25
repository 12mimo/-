import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../styles/color.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

/// 消息模型
class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final File? image; // 图片附件

  Message({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.image,
  });
}

/// 聊天页面
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int _currentLines = 1;
  final int _maxVisibleLines = 5;
  final int _lineThreshold = 3; // 超过多少行时显示全屏编辑按钮
  bool _showEmojiPicker = false;
  late AppStyle appStyle;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateLineCount);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateLineCount);
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// 更新输入框当前行数
  void _updateLineCount() {
    final text = _controller.text;
    final span = TextSpan(text: text, style: const TextStyle(fontSize: 16));
    final tp = TextPainter(
      text: span,
      maxLines: _maxVisibleLines,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: MediaQuery.of(context).size.width - 82); // 减去Padding和按钮宽度
    final numLines = tp.computeLineMetrics().length;
    setState(() {
      _currentLines = numLines;
    });
  }

  /// 发送消息
  void _sendMessage(String text, {File? image}) {
    if (text.trim().isEmpty && image == null) return;
    setState(() {
      _messages.add(Message(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
        image: image,
      ));
      // 模拟虚拟咨询师回复
      _messages.add(Message(
        text: _getBotResponse(text),
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
    _controller.clear();
    _scrollToBottom();
  }

  /// 模拟虚拟咨询师回复
  String _getBotResponse(String userMessage) {
    return "感谢您的分享。您能详细说明一下吗？";
  }

  /// 滚动到聊天底部
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 60,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// 打开全屏编辑页面
  Future<void> _openFullScreenEditor() async {
    final fullText = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => FullScreenEditorPage(initialText: _controller.text),
      ),
    );

    if (fullText != null && fullText is String) {
      setState(() {
        _controller.text = fullText;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: fullText.length));
      });
      _updateLineCount();
    }
  }

  /// 选择图片附件
  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
      await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

      if (pickedFile != null) {
        _sendMessage('', image: File(pickedFile.path));
      }
    } catch (e) {
      print('Image picker error: $e');
      _showErrorDialog('无法选择图片，请重试。');
    }
  }

  /// 显示错误对话框
  void _showErrorDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('错误'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('确定'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  /// 格式化时间戳
  String _formatTimestamp(DateTime timestamp) {
    final hours = timestamp.hour.toString().padLeft(2, '0');
    final minutes = timestamp.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    appStyle = AppStyle(context);
    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          '虚拟咨询师',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: appStyle.backgroundColor,
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            _showEmojiPicker = false;
          });
        },
        child: Column(
          children: [
            // 消息列表
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message.isUser;
                  return AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: isUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isUser)
                            const CircleAvatar(
                              backgroundImage:
                              AssetImage('assets/consultant_avatar.png'),
                            ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: isUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 14),
                                  decoration: BoxDecoration(
                                    color: isUser
                                        ? appStyle.primaryColor
                                        : appStyle.cardBackgroundColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: isUser
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      if (message.image != null)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Image.file(
                                            message.image!,
                                            width: 200,
                                          ),
                                        ),
                                      Text(
                                        message.text,
                                        style: TextStyle(
                                          color: isUser
                                              ? Colors.white
                                              : appStyle.textColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _formatTimestamp(message.timestamp),
                                  style: TextStyle(
                                    color: appStyle.textColor.withOpacity(0.6),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (isUser)
                            const CircleAvatar(
                              backgroundImage:
                              AssetImage('assets/user_avatar.png'),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(color: appStyle.dividerColor ?? Colors.grey),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      controller: _controller,
                      placeholder: '输入您的消息...',
                      decoration: BoxDecoration(
                        color: appStyle.cardBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      maxLines: _maxVisibleLines,
                      minLines: 1,
                      textInputAction: TextInputAction.newline,
                    ),
                  ),
                  const SizedBox(width: 5),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _pickImage,
                    child: Icon(
                      CupertinoIcons.paperclip,
                      color: appStyle.primaryColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_currentLines > _lineThreshold)
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: _openFullScreenEditor,
                          child: const Icon(
                            CupertinoIcons.arrow_up_right_square,
                            color: Color(0xFF4A90E2),
                            size: 28,
                          ),
                        ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => _sendMessage(_controller.text),
                        child: Icon(
                          CupertinoIcons.arrow_up_circle_fill,
                          color: appStyle.primaryColor,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 全屏编辑页面
class FullScreenEditorPage extends StatefulWidget {
  final String initialText;

  const FullScreenEditorPage({super.key, required this.initialText});

  @override
  _FullScreenEditorPageState createState() => _FullScreenEditorPageState();
}

class _FullScreenEditorPageState extends State<FullScreenEditorPage> {
  late TextEditingController _fullController;

  @override
  void initState() {
    super.initState();
    _fullController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _fullController.dispose();
    super.dispose();
  }

  /// 提交编辑的文本
  void _submit() {
    final text = _fullController.text.trim();
    Navigator.pop(context, text);
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _fullController.text);
        return false;
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            '全屏编辑',
            style: TextStyle(
              color: appStyle.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _submit,
            child: Text(
              '发送',
              style: TextStyle(
                color: appStyle.primaryColor,
                fontSize: 16,
              ),
            ),
          ),
          backgroundColor: appStyle.backgroundColor,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CupertinoTextField(
              controller: _fullController,
              placeholder: '输入您的消息...',
              decoration: BoxDecoration(
                color: appStyle.cardBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              maxLines: null,
              textInputAction: TextInputAction.newline,
              autofocus: true,
            ),
          ),
        ),
      ),
    );
  }
}
