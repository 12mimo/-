import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VirtualConsultantPage extends StatelessWidget {
  const VirtualConsultantPage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final primaryColor = isDarkMode ? Color(0xFF80CBC4) : Color(0xFF00838F);
    final backgroundColor = isDarkMode ? const Color(0xFF37474F) : const Color(0xFFF5F5F5);
    final textColor = isDarkMode ? Color(0xFFCFD8DC) : Color(0xFF546E7A);
    final contentColor = isDarkMode ? Color(0xFFB0BEC5) : Color(0xFF455A64);
    final cardBackgroundColor = primaryColor.withOpacity(0.1);

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
        padding: const EdgeInsets.only(bottom: 70.0),
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