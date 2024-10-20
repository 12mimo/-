import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart'; // 用于平台通道
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechRecognitionPage extends StatefulWidget {
  const SpeechRecognitionPage({Key? key}) : super(key: key);

  @override
  _SpeechRecognitionPageState createState() => _SpeechRecognitionPageState();
}

class _SpeechRecognitionPageState extends State<SpeechRecognitionPage> {
  static const platform = MethodChannel('com.example.tts/tts');
  String _recognizedText = "开始说话...";
  String _responseText = "";

  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();

    // 初始化语音识别并开始监听
    _initSpeechRecognition();
  }

  void _initSpeechRecognition() async {
    bool available = await _speech.initialize(
      onStatus: (val) => print('状态: $val'),
      onError: (val) => print('错误: $val'),
    );

    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (val) => setState(() {
          _recognizedText = val.recognizedWords;
        }),
      );
    } else {
      setState(() => _isListening = false);
      print("语音识别不可用");
    }
  }

  // 调用原生TTS
  Future<void> _speak(String text) async {
    try {
      await platform.invokeMethod('speak', {'text': text});
    } on PlatformException catch (e) {
      print("Failed to invoke TTS: '${e.message}'.");
    }
  }

  void _sendToServer(String recognizedText) async {
    final response = await http.post(
      Uri.parse('https://your-server-url.com/api'), // 替换为你的服务器地址
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': recognizedText,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _responseText = jsonDecode(response.body)['reply'];
      });

      // 使用原生TTS播放服务器回复的文本
      _speak(_responseText);
    } else {
      // 处理错误
      print('服务器错误');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('语音对话')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_recognizedText),
            ElevatedButton(
              onPressed: () {
                _sendToServer(_recognizedText); // 将识别文本发送到服务器
              },
              child: Text('发送到服务器'),
            ),
          ],
        ),
      ),
    );
  }
}
