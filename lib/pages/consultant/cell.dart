import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class CounselorCallPage extends StatefulWidget {
  @override
  _CounselorCallPageState createState() => _CounselorCallPageState();
}

class _CounselorCallPageState extends State<CounselorCallPage> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _recognizedText = "";

  void _toggleListening() async {
    if (_isListening) {
      await _speech.stop();
    } else {
      bool available = await _speech.initialize();
      if (available) {
        _speech.listen(onResult: (result) {
          setState(() {
            _recognizedText = result.recognizedWords;
          });
        });
      }
    }
    setState(() {
      _isListening = !_isListening;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('与心理咨询师对话'),
        trailing: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(CupertinoIcons.clear),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isListening ? '正在听取...' : '点击开始对话',
                  style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle.copyWith(
                    color: Colors.black87,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                CupertinoButton(
                  color: _isListening ? CupertinoColors.destructiveRed : CupertinoColors.activeBlue,
                  onPressed: _toggleListening,
                  child: Text(_isListening ? '停止对话' : '开始对话'),
                ),
                SizedBox(height: 20),
                if (_isListening)
                  CupertinoActivityIndicator(radius: 20) // 加载指示器
                else
                  Icon(
                    CupertinoIcons.mic,
                    size: 50,
                    color: CupertinoColors.systemGrey,
                  ),
                SizedBox(height: 20),
                Text(
                  _recognizedText,
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
