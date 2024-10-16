import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final primaryColor = isDarkMode ? Color(0xFF80CBC4) : Color(0xFF00838F);
    final backgroundColor =
    isDarkMode ? const Color(0xFF80CBC4) : const Color(0xFFB2EBF2);
    final cardBackgroundColor = isDarkMode ? Color(0xFF37474F) : Color(0xFFB2EBF2);
    final accentColor = isDarkMode ? Color(0xFF26A69A) : Color(0xFF00796B);
    final textColor = isDarkMode ? Color(0xFFCFD8DC) : Color(0xFF37474F);

    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '心理健康助手',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: backgroundColor,
        border: Border.all(color: Colors.transparent),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(primaryColor, accentColor),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildCard(
                      title: '今日心理提示',
                      content: '保持内心的平静，对自己温柔一些。每天给自己一点独处的时间。',
                      backgroundColor: cardBackgroundColor,
                      titleColor: primaryColor,
                      contentColor: textColor,
                      icon: Icons.self_improvement,
                    ),
                    const SizedBox(height: 16),
                    _buildCard(
                      title: '推荐活动',
                      content:
                      '1. 每天进行10分钟的冥想，放松身心。\n2. 写下三件让你感到感激的事情。\n3. 与好友聊聊你最近的感受。',
                      backgroundColor: cardBackgroundColor,
                      titleColor: primaryColor,
                      contentColor: textColor,
                      icon: Icons.favorite,
                    ),
                    const SizedBox(height: 16),
                    _buildCard(
                      title: '心理知识',
                      content: '心理健康是指一种积极的心理状态...',
                      backgroundColor: cardBackgroundColor,
                      titleColor: primaryColor,
                      contentColor: textColor,
                      icon: Icons.psychology,
                    ),
                    const SizedBox(height: 16),
                    _buildCard(
                      title: '感恩日记',
                      content: '写下今天你感激的三件事情...',
                      backgroundColor: cardBackgroundColor,
                      titleColor: primaryColor,
                      contentColor: textColor,
                      icon: Icons.book,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(Color primaryColor, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withOpacity(0.5), accentColor.withOpacity(0.5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.mood,
                color: accentColor,
                size: 40,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '欢迎来到心理健康助手',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '帮助你保持心理健康，找到内心的平静。',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String content,
    required Color backgroundColor,
    required Color titleColor,
    required Color contentColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: _buildBoxDecoration(backgroundColor),
      child: Row(
        children: [
          Icon(
            icon,
            color: titleColor,
            size: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 16,
                    color: contentColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(Color color, {double opacity = 0.1}) {
    return BoxDecoration(
      color: color.withOpacity(opacity),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }
}