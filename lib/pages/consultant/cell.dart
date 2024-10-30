import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

class CounselorCallPage extends StatefulWidget {
  const CounselorCallPage({Key key}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CounselorCallPage> {
  Stopwatch _stopwatch;
  bool _isCalling = false;
  String _duration = "00:00";
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String _lastWords = "";

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _requestMicrophonePermission();
  }

  void _requestMicrophonePermission() async {
    await Permission.microphone.request();
  }

  void _startCall() {
    setState(() {
      _isCalling = true;
    });
    _stopwatch.start();
    _startListening();
    _updateDuration();
  }

  void _endCall() {
    setState(() {
      _isCalling = false;
      _duration = "00:00";
      _lastWords = "";
    });
    _stopwatch.stop();
    _speechToText.stop();
  }

  void _startListening() async {
    if (await _speechToText.initialize()) {
      setState(() {
        _isListening = true;
      });
      _speechToText.listen(onResult: (result) {
        setState(() {
          _lastWords = result.recognizedWords;
        });
      });
    }
  }

  void _updateDuration() {
    if (_isCalling) {
      setState(() {
        _duration = _formatDuration(_stopwatch.elapsed);
      });
      Future.delayed(Duration(seconds: 1), _updateDuration);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('拨打电话'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isCalling ? '通话中...' : '通话已结束',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              '通话时长: $_duration',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            if (_lastWords.isNotEmpty)
              Text(
                '你刚刚说: $_lastWords',
                style: TextStyle(fontSize: 18),
              ),
            SizedBox(height: 20),
            CupertinoButton(
              child: Text(_isCalling ? '结束通话' : '拨打电话'),
              onPressed: _isCalling ? _endCall : _startCall,
            ),
          ],
        ),
      ),
    );
  }
}
