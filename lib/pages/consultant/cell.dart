import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class CounselorCallPage extends StatelessWidget {
  const CounselorCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VoiceChatScreen(),
    );
  }
}

class VoiceChatScreen extends StatefulWidget {
  const VoiceChatScreen({super.key});

  @override
  VoiceChatScreenState createState() => VoiceChatScreenState();
}

class VoiceChatScreenState extends State<VoiceChatScreen> {
  late stt.SpeechToText _speech; // 语音识别实例
  bool _isListening = false; // 是否在监听语音
  String _text = ''; // 识别的文本
  final List<Map<String, String>> _messages = []; // 聊天记录
  late FlutterTts _flutterTts; // TTS实例

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
  }

  // 开始监听语音
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(onStatus: _onSpeechStatus);
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
            onResult: (val) => setState(() {
                  _text = val.recognizedWords;
                }));
      }
    }
  }

  // 监听语音状态，当结束时自动处理
  void _onSpeechStatus(String status) {
    if (status == 'done') {
      setState(() => _isListening = false);
      if (_text.isNotEmpty) {
        _sendMessage(_text); // 将语音识别到的文本发送
      }
    }
  }

  // 发送消息并生成 AI 回复
  void _sendMessage(String message) {
    setState(() {
      _messages.add({'sender': 'user', 'message': message});
      String aiResponse = '这是 AI 的回复: $message'; // 模拟 AI 回复
      _messages.add({'sender': 'ai', 'message': aiResponse});
      _speak(aiResponse); // 使用 TTS 语音播放 AI 回复
    });
  }

  // 播放 AI 的语音回复
  void _speak(String text) async {
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('语音对话页面'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // 返回上一页
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          _buildVoiceInputArea(), // 优化的语音输入区域
        ],
      ),
    );
  }

  // 构建消息显示，增加美观的 UI 设计
  Widget _buildMessage(Map<String, String> message) {
    bool isUser = message['sender'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: isUser ? Colors.blue[100] : Colors.green[100],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            message['message']!,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  // 构建优化后的语音输入区域
  Widget _buildVoiceInputArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _isListening ? '正在听，请讲话...' : '点击麦克风开始',
              style: TextStyle(fontSize: 16),
            ),
          ),
          FloatingActionButton(
            onPressed: _listen,
            backgroundColor: _isListening ? Colors.red : Colors.blue,
            child: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
