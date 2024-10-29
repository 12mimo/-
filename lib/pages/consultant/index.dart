import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xlfz/pages/consultant/test.dart';

import '../../styles/color.dart';
import 'cell.dart';
import 'cell_1.dart';
import 'chat.dart';

class VirtualConsultantPage extends StatelessWidget {
  const VirtualConsultantPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '心灵顾问',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: appStyle.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildFullWidthSection(_buildWelcomeSection(appStyle.primaryColor,
              //     appStyle.textColor, appStyle.cardBackgroundColor, context)),
              // SizedBox(height: 15),
              // Divider(color: appStyle.dividerColor ?? Colors.grey),
              SizedBox(height: 15),
              _buildFullWidthSection(_buildVirtualAdvisorSection(
                  appStyle.primaryColor,
                  appStyle.textColor,
                  appStyle.cardBackgroundColor,
                  context)),
              SizedBox(height: 15),
              Divider(color: appStyle.dividerColor ?? Colors.grey),
              SizedBox(height: 15),
              _buildFullWidthSection(_buildMindAdvisorSection(
                  appStyle.primaryColor,
                  appStyle.textColor,
                  appStyle.cardBackgroundColor,
                  context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFullWidthSection(Widget child) {
    return SizedBox(
      width: double.infinity,
      child: child,
    );
  }

  Widget _buildWelcomeSection(Color primaryColor, Color textColor,
      Color cardBackgroundColor, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            size: 60,
            color: primaryColor,
          ),
          SizedBox(height: 20),
          Text(
            '欢迎来到心灵顾问',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '这里可以帮助您进行心理状态的评估和调节。请根据以下提示开始您的心理健康之旅。',
            style: TextStyle(fontSize: 18, color: textColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          CupertinoButton(
            color: primaryColor,
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => PlaceholderPage(),
                ),
              );
            },
            child:
                const Text('开始心理健康之旅', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildVirtualAdvisorSection(Color primaryColor, Color textColor,
      Color cardBackgroundColor, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.psychology,
            size: 60,
            color: primaryColor,
          ),
          SizedBox(height: 20),
          Text(
            '虚拟咨询师',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          SizedBox(height: 10),
          Text(
            '随时随地为您提供心理健康支持，帮助您应对情绪问题，保持良好的心态。',
            style: TextStyle(fontSize: 18, color: textColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          CupertinoButton(
            color: primaryColor,
            onPressed: () async {
              var status = await Permission.microphone.status;

// 检查是否被拒绝或是初次申请
              if (status.isDenied || status.isRestricted) {
                // 请求权限
                status = await Permission.microphone.request();
              }

// 检查是否已经授予权限
              if (status.isGranted) {
                print("Microphone permission granted.");
              }
// 检查是否永久拒绝
              else if (status.isPermanentlyDenied) {
                // 打开设置页面
                openAppSettings();
              } else {
                print("Microphone permission denied.");
              }
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CounselorCallPage(),
                ),
              );
            },

            child: const Text('开始语音对话', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildMindAdvisorSection(Color primaryColor, Color textColor,
      Color cardBackgroundColor, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.self_improvement,
            size: 60,
            color: primaryColor,
          ),
          SizedBox(height: 20),
          Text(
            '心灵顾问',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          SizedBox(height: 10),
          Text(
            '提供个性化的心理健康建议，帮助您更好地理解自己，提升心灵的平衡与幸福感。',
            style: TextStyle(fontSize: 18, color: textColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          CupertinoButton(
            color: primaryColor,
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const ChatPage(),
                ),
              );
            },
            child: const Text('开启对话', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
