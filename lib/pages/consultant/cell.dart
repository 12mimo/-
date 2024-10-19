import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/color.dart';

class CounselorCallPage extends StatefulWidget {
  @override
  _CounselorCallPageState createState() => _CounselorCallPageState();
}

class _CounselorCallPageState extends State<CounselorCallPage> {
  Duration _callDuration = Duration();
  Timer? _timer; // 将 Timer 声明为可空类型

  @override
  void initState() {
    super.initState();
    _startCallTimer();
  }

  void _startCallTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _callDuration = Duration(seconds: _callDuration.inSeconds + 1);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // 使用空安全操作符
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:"
        "${twoDigits(duration.inMinutes.remainder(60))}:"
        "${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // 返回上一页
          },
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        backgroundColor: appStyle.backgroundColor,
        border: null,
        middle: Text(
          '心理咨询通话',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CupertinoColors.white,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            // 挂断通话的功能
          },
          child: Icon(
            CupertinoIcons.phone_down_fill,
            color: CupertinoColors.systemRed,
          ),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // 背景
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    appStyle.backgroundColor,
                    appStyle.cardBackgroundColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // 内容
            Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          // backgroundImage: NetworkImage(
                          //     'https://example.com/counselor-avatar.jpg'),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '正在与张医生通话中...',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _formatDuration(_callDuration),
                          style: TextStyle(
                            fontSize: 20,
                            color: CupertinoColors.white.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(height: 30),
                        Icon(
                          CupertinoIcons.waveform,
                          size: 100,
                          color: CupertinoColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                _buildSafetyTip(),
              ],
            ),
            // 底部悬浮操作按钮
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFloatingActionButton(
                    CupertinoIcons.mic_off,
                    '静音',
                    CupertinoColors.white,
                  ),
                  _buildFloatingActionButton(
                    CupertinoIcons.speaker_2_fill,
                    '扬声器',
                    CupertinoColors.white,
                  ),
                  _buildFloatingActionButton(
                    CupertinoIcons.question_circle_fill,
                    '帮助',
                    CupertinoColors.white,
                  ),
                  _buildFloatingActionButton(
                    CupertinoIcons.pencil_outline,
                    '记录',
                    CupertinoColors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(
      IconData icon, String label, Color iconColor,
      {Color backgroundColor = Colors.white24}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: CupertinoButton(
            onPressed: () {
              // 功能实现
            },
            padding: EdgeInsets.all(15),
            child: Icon(icon, color: iconColor, size: 30),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: CupertinoColors.white),
        ),
      ],
    );
  }

  Widget _buildSafetyTip() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        '提示：您的隐私受到保护，通话内容不会被记录。',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14, color: CupertinoColors.white.withOpacity(0.8)),
      ),
    );
  }
}
