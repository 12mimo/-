import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/index.dart';

class VirtualConsultantPage extends StatelessWidget {
  const VirtualConsultantPage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final primaryColor = isDarkMode ? AppColors.darkPrimaryColor : AppColors.lightPrimaryColor;
    final backgroundColor =
    isDarkMode ? AppColors.darkBackgroundColor : AppColors.lightBackgroundColor;
    final textColor = isDarkMode ? AppColors.darkTextColor : AppColors.lightTextColor;
    final contentColor = isDarkMode ? AppColors.darkContentColor : AppColors.lightContentColor;
    final cardBackgroundColor = isDarkMode ? AppColors.darkCardBackgroundColor : AppColors.lightCardBackgroundColor;

    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '心灵顾问',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFullWidthSection(_buildWelcomeSection(cardBackgroundColor, contentColor)),
              SizedBox(height: 30),
              _buildFullWidthSection(_buildVirtualAdvisorSection(primaryColor, textColor, cardBackgroundColor)),
              SizedBox(height: 30),
              _buildFullWidthSection(_buildMindAdvisorSection(primaryColor, textColor, cardBackgroundColor)),
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

  Widget _buildWelcomeSection(Color cardBackgroundColor, Color contentColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '欢迎来到心灵顾问，这里可以帮助您进行心理状态的评估和调节。请根据以下提示开始您的心理健康之旅。',
        style: TextStyle(fontSize: 18, color: contentColor),
      ),
    );
  }

  Widget _buildVirtualAdvisorSection(Color primaryColor, Color textColor, Color cardBackgroundColor) {
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
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: primaryColor),
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
            onPressed: () {},
            child: const Text('开始对话', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildMindAdvisorSection(Color primaryColor, Color textColor, Color cardBackgroundColor) {
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
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: primaryColor),
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
            onPressed: () {},
            child: const Text('获取建议', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}