import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final primaryColor = isDarkMode ? Color(0xFF80CBC4) : Color(0xFF00838F);
    final backgroundColor =
        isDarkMode ? const Color(0xFF37474F) : const Color(0xFFF5F5F5);
    final textColor = isDarkMode ? Color(0xFFCFD8DC) : Color(0xFF546E7A);
    final contentColor = isDarkMode ? Color(0xFFB0BEC5) : Color(0xFF455A64);
    final cardBackgroundColor = primaryColor.withOpacity(0.1);

    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '心理健康助手',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 90.0),
          child: Container(
            color: backgroundColor,
            child: ListView(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
              children: [
                _buildCard(
                  title: '今日心理提示',
                  content: '保持内心的平静，对自己温柔一些。每天给自己一点独处的时间。',
                  backgroundColor: cardBackgroundColor,
                  titleColor: primaryColor,
                  contentColor: contentColor,
                ),
                const SizedBox(height: 20),
                _buildCard(
                  title: '推荐活动',
                  content:
                      '1. 每天进行10分钟的冥想，放松身心。\n2. 写下三件让你感到感激的事情。\n3. 与好友聊聊你最近的感受。',
                  backgroundColor: cardBackgroundColor,
                  titleColor: primaryColor,
                  contentColor: contentColor,
                ),
                const SizedBox(height: 20),
                _buildMentalHealthKnowledgeSection(
                    primaryColor, textColor, contentColor, primaryColor),
                const SizedBox(height: 20),
                _buildGratitudeJournalSection(
                    primaryColor, textColor, contentColor, primaryColor),
                const SizedBox(height: 20),
                _buildPsychologicalTestsSection(
                    primaryColor, textColor, contentColor, primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 样式统一的卡片
  Widget _buildCard({
    required String title,
    required String content,
    required Color backgroundColor,
    required Color titleColor,
    required Color contentColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: _buildBoxDecoration(backgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 18,
              color: contentColor,
            ),
          ),
        ],
      ),
    );
  }

  // 心理知识部分
  Widget _buildMentalHealthKnowledgeSection(Color primaryColor,
      Color titleColor, Color contentColor, Color titleBackgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: _buildBoxDecoration(primaryColor, opacity: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '心理知识',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: titleBackgroundColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '心理健康是指一种积极的心理状态...',
            style: TextStyle(
              fontSize: 18,
              color: contentColor,
            ),
          ),
        ],
      ),
    );
  }

  // 感恩日记部分
  Widget _buildGratitudeJournalSection(Color primaryColor, Color titleColor,
      Color contentColor, Color titleBackgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: _buildBoxDecoration(primaryColor, opacity: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '感恩日记',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: titleBackgroundColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '写下三件让你感到感激的事情...',
            style: TextStyle(
              fontSize: 18,
              color: contentColor,
            ),
          ),
        ],
      ),
    );
  }

  // 心理测试模块
  Widget _buildPsychologicalTestsSection(Color primaryColor, Color titleColor,
      Color contentColor, Color titleBackgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: _buildBoxDecoration(primaryColor, opacity: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '心理测试',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: titleBackgroundColor,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: List.generate(10, (index) {
              return CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  // 测试点击事件处理
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '心理测试 ${index + 1}',
                        style: TextStyle(
                          fontSize: 18,
                          color: contentColor,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.chevron_forward,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(Color color, {double opacity = 0.1}) {
    return BoxDecoration(
      color: color.withOpacity(opacity),
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
}
