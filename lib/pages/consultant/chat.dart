// lib/pages/consultant/chat.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../styles/color.dart';
import 'dart:io';

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
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int _currentLines = 1;
  final int _maxVisibleLines = 5;
  final int _lineThreshold = 3; // 超过多少行时显示全屏编辑按钮
  bool _showEmojiPicker = false;
  bool _isListening = false;
  late stt.SpeechToText _speech;
  late AppStyle appStyle;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateLineCount);
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    _controller.removeListener(_updateLineCount);
    _controller.dispose();
    _scrollController.dispose();
    _speech.stop();
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
    tp.layout(
        maxWidth:
            MediaQuery.of(context).size.width - 32 - 50); // 减去Padding和按钮宽度
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
    // 这里可以集成实际的对话逻辑或API调用
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
        builder: (context) =>
            FullScreenEditorPage(initialText: _controller.text),
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
      // 您可以在这里添加用户提示，例如使用SnackBar或CupertinoAlertDialog
      _showErrorDialog('无法选择图片，请重试。');
    }
  }

  /// 开始语音识别
  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('Speech status: $val');
          if (val == 'done' || val == 'notListening') {
            setState(() {
              _isListening = false;
            });
          }
        },
        onError: (val) {
          print('Speech error: $val');
          setState(() {
            _isListening = false;
          });
        },
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _controller.text = val.recognizedWords;
              _controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: _controller.text.length));
            });
            _updateLineCount();
          },
          // 移除 ListenOptions 并使用命名参数
          listenFor: Duration(seconds: 60),
          pauseFor: Duration(seconds: 3),
          partialResults: true,
          localeId: 'zh_CN',
          // 根据需要设置语言
          cancelOnError: true,
          listenMode: stt.ListenMode.confirmation,
        );
        print('Started listening');
      } else {
        print('The user has denied the use of speech recognition.');
        _showErrorDialog('无法启动语音识别，请检查权限设置。');
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      print('Stopped listening');
    }
  }

  /// 切换表情选择器
  void _toggleEmojiPicker() {
    FocusScope.of(context).unfocus();
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
  }

  /// 格式化时间戳
  String _formatTimestamp(DateTime timestamp) {
    final hours = timestamp.hour.toString().padLeft(2, '0');
    final minutes = timestamp.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  /// 显示错误对话框
  void _showErrorDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('错误'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text('确定'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    appStyle = AppStyle(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
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
                            CircleAvatar(
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
                            CircleAvatar(
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
            // 分割线
            Divider(color: appStyle.dividerColor ?? Colors.grey),
            // 输入框和按钮
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  // 语音输入按钮
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _listen,
                    child: Icon(
                      _isListening
                          ? CupertinoIcons.mic_fill
                          : CupertinoIcons.mic,
                      color: appStyle.primaryColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 5),
                  // 输入框
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
                      // 设置最大行数
                      minLines: 1,
                      // 设置最小行数
                      textInputAction: TextInputAction.newline, // 允许换行
                    ),
                  ),
                  const SizedBox(width: 5),
                  // 表情按钮
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _toggleEmojiPicker,
                    child: Icon(
                      CupertinoIcons.smiley,
                      color: appStyle.primaryColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 5),
                  // 附件按钮
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
                  // 按钮区域
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_currentLines > _lineThreshold)
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: _openFullScreenEditor,
                          child: const Icon(
                            CupertinoIcons.arrow_up_right_square, // 有效的图标
                            color: Color(0xFF4A90E2), // 主色调
                            size: 28,
                          ),
                        ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => _sendMessage(_controller.text),
                        child: const Icon(
                          CupertinoIcons.arrow_up_circle_fill,
                          color: Color(0xFF4A90E2), // 主色调
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 表情选择器
            _showEmojiPicker
                ? SizedBox(
                    height: 250,
                    child: EmojiPicker(
                      onEmojiSelected: (Category? category, Emoji emoji) {
                        setState(() {
                          _controller.text += emoji.emoji;
                          _controller.selection = TextSelection.fromPosition(
                              TextPosition(offset: _controller.text.length));
                        });
                        _updateLineCount();
                      },
                      config: Config(
                        columns: 7,
                        emojiSizeMax: 32,
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        initCategory: Category.SMILEYS,
                        bgColor: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        indicatorColor: appStyle.primaryColor,
                        iconColor: appStyle.primaryColor,
                        iconColorSelected: Colors.blue,
                        backspaceColor: appStyle.primaryColor,
                        skinToneDialogBgColor: appStyle.cardBackgroundColor,
                        skinToneIndicatorColor: appStyle.primaryColor,
                        enableSkinTones: true,
                        // 移除 showRecentsTab 参数
                        // showRecentsTab: true,
                        recentsLimit: 28,
                        noRecents: Text('没有最近的表情'),
                        tabIndicatorAnimDuration:
                            const Duration(milliseconds: 300),
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL,
                      ),
                    ),
                  )
                : Container(),
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
        // 当用户点击返回按钮时，也返回当前文本
        Navigator.pop(context, _fullController.text);
        return false; // 已经处理了pop
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
              // 允许无限行
              textInputAction: TextInputAction.newline,
              // 允许换行
              autofocus: true,
            ),
          ),
        ),
      ),
    );
  }
}
