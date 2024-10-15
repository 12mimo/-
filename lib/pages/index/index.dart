import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart'; // 确保你已经添加了fl_chart库依赖

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      ),
      child: Container(
        color: backgroundColor,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0, bottom: 90.0),
            children: [
              _buildHealthDataLineChart('睡眠', [FlSpot(0, 6), FlSpot(4, 7), FlSpot(8, 6.5), FlSpot(12, 7.2), FlSpot(16, 6.8)], primaryColor, textColor, cardBackgroundColor),
              const SizedBox(height: 20),
              _buildHealthDataLineChart('步数', [FlSpot(0, 3000), FlSpot(4, 5000), FlSpot(8, 8000), FlSpot(12, 10000), FlSpot(16, 12000)], primaryColor, textColor, cardBackgroundColor),
              const SizedBox(height: 20),
              _buildHealthDataLineChart('心率', [FlSpot(0, 70), FlSpot(4, 75), FlSpot(8, 80), FlSpot(12, 85), FlSpot(16, 78)], primaryColor, textColor, cardBackgroundColor),
              const SizedBox(height: 20),
              _buildHealthDataLineChart('呼吸', [FlSpot(0, 15), FlSpot(4, 14), FlSpot(8, 16), FlSpot(12, 15), FlSpot(16, 14)], primaryColor, textColor, cardBackgroundColor),
              const SizedBox(height: 20),
              _buildHealthDataLineChart('活动能量', [FlSpot(0, 200), FlSpot(4, 300), FlSpot(8, 400), FlSpot(12, 500), FlSpot(16, 450)], primaryColor, textColor, cardBackgroundColor),
              const SizedBox(height: 20),
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
              _buildMentalHealthKnowledgeSection(primaryColor, textColor, contentColor, primaryColor),
              const SizedBox(height: 20),
              _buildGratitudeJournalSection(primaryColor, textColor, contentColor, primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  // 折线图展示健康数据
  Widget _buildHealthDataLineChart(String title, List<FlSpot> dataPoints, Color primaryColor, Color textColor, Color cardBackgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: _buildBoxDecoration(cardBackgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title 数据趋势',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true, drawVerticalLine: true),
                borderData: FlBorderData(show: true, border: Border.all(color: textColor)),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, interval: 10, getTitlesWidget: (value, meta) => Text(value.toString(), style: TextStyle(color: textColor, fontSize: 12))),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 0:
                          return Text('0:00', style: TextStyle(color: textColor, fontSize: 12));
                        case 4:
                          return Text('4:00', style: TextStyle(color: textColor, fontSize: 12));
                        case 8:
                          return Text('8:00', style: TextStyle(color: textColor, fontSize: 12));
                        case 12:
                          return Text('12:00', style: TextStyle(color: textColor, fontSize: 12));
                        case 16:
                          return Text('16:00', style: TextStyle(color: textColor, fontSize: 12));
                        case 20:
                          return Text('20:00', style: TextStyle(color: textColor, fontSize: 12));
                        case 24:
                          return Text('24:00', style: TextStyle(color: textColor, fontSize: 12));
                      }
                      return Text('', style: TextStyle(color: textColor, fontSize: 12));
                    }),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: dataPoints,
                    isCurved: true,
                    barWidth: 4,
                    color: primaryColor,
                    belowBarData: BarAreaData(show: true, color: primaryColor.withOpacity(0.3)),
                    dotData: FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),
        ],
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
  Widget _buildMentalHealthKnowledgeSection(Color primaryColor, Color titleColor, Color contentColor, Color titleBackgroundColor) {
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
  Widget _buildGratitudeJournalSection(Color primaryColor, Color titleColor, Color contentColor, Color titleBackgroundColor) {
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
