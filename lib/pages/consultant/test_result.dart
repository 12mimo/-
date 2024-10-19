import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/color.dart';

class ResultsPage extends StatelessWidget {
  final String mbtiType;

  ResultsPage({required this.mbtiType});

  // 根据MBTI类型提供不同的描述
  final Map<String, String> mbtiDescriptions = {
    'INTJ': '战略家型：具有独立思考能力，善于规划和实现目标。',
    'INTP': '逻辑学家型：喜欢分析问题，善于逻辑推理和创新。',
    'ENTJ': '指挥官型：天生的领导者，善于组织和管理。',
    'ENTP': '辩论家型：喜欢挑战现状，善于辩论和创新。',
    'INFJ': '顾问型：富有同理心，善于理解他人和提供支持。',
    'INFP': '调解者型：理想主义者，追求内心的和谐与意义。',
    'ENFJ': '主人公型：具有领导魅力，善于激励和影响他人。',
    'ENFP': '活动家型：充满热情，善于创造和探索新事物。',
    'ISTJ': '检查员型：务实可靠，注重细节和责任感。',
    'ISFJ': '护卫者型：关心他人，具有强烈的责任感和忠诚度。',
    'ESTJ': '执行者型：组织能力强，善于管理和实施计划。',
    'ESFJ': '领事型：社交能力强，关心他人的需求和感受。',
    'ISTP': '工匠型：喜欢动手实践，善于解决实际问题。',
    'ISFP': '艺术家型：富有创造力，喜欢表达和体验美。',
    'ESTP': '实干家型：喜欢冒险和刺激，善于即时决策和行动。',
    'ESFP': '表演者型：充满活力，喜欢与人互动和享受当下。',
    // 添加更多类型的描述
  };

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    String description = mbtiDescriptions[mbtiType] ?? '未知类型';

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '测试结果',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: appStyle.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.popUntil(context, (route) => route.isFirst); // 返回主页
          },
          child: Icon(
            CupertinoIcons.home,
            color: appStyle.primaryColor,
          ),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '您的MBTI类型是：',
                  style: TextStyle(
                    fontSize: 20,
                    color: appStyle.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  mbtiType,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: appStyle.primaryColor,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 18,
                    color: appStyle.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                CupertinoButton.filled(
                  child: Text('返回主页'),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
