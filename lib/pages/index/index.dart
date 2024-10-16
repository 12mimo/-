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
    isDarkMode ? const Color(0xFF263238) : const Color(0xFFE0F7FA);
    final textColor = isDarkMode ? Color(0xFFCFD8DC) : Color(0xFF37474F);
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
            fontSize: 22,
          ),
        ),
        backgroundColor: backgroundColor,
        border: Border.all(color: Colors.transparent),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Container(
            color: backgroundColor,
            child: ListView(
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
                    primaryColor, textColor, contentColor),
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 18,
              color: contentColor,
              height: 1.5,
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
      padding: const EdgeInsets.all(20.0),
      decoration: _buildBoxDecoration(primaryColor, opacity: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '心理知识',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: titleBackgroundColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '心理健康是指一种积极的心理状态...',
            style: TextStyle(
              fontSize: 18,
              color: contentColor,
              height: 1.5,
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
      padding: const EdgeInsets.all(20.0),
      decoration: _buildBoxDecoration(primaryColor, opacity: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '感恩日记',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: titleBackgroundColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '写下今天你感激的三件事情...',
            style: TextStyle(
              fontSize: 18,
              color: contentColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // 心理测试部分
  Widget _buildPsychologicalTestsSection(Color primaryColor, Color titleColor,
      Color contentColor) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.15),
            offset: const Offset(0, 6),
            blurRadius: 12.0,
          ),
        ],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: 1.5,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withOpacity(0.15),
                  primaryColor.withOpacity(0.25),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.15),
                  offset: const Offset(0, 6),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: CupertinoButton(
              padding: const EdgeInsets.all(16.0),
              onPressed: () {
                // 测试点击事件处理
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.heart_fill,
                    color: primaryColor,
                    size: 30.0,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '心理测试 ${index + 1}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: contentColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(Color color, {double opacity = 0.1}) {
    return BoxDecoration(
      color: color.withOpacity(opacity),
      borderRadius: BorderRadius.circular(20.0),
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