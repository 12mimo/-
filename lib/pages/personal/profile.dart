import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final primaryColor = isDarkMode ? const Color(0xFF80CBC4) : const Color(0xFF00838F);
    final backgroundColor = isDarkMode ? const Color(0xFF37474F) : const Color(0xFFF5F5F5);
    final textColor = isDarkMode ? const Color(0xFFCFD8DC) : const Color(0xFF546E7A);
    final contentColor = isDarkMode ? const Color(0xFFB0BEC5) : const Color(0xFF455A64);
    final cardBackgroundColor = primaryColor.withOpacity(0.1);

    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '个人中心',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFullWidthSection(_buildProfileHeaderSection(primaryColor, textColor, cardBackgroundColor)),
          const SizedBox(height: 20),
          _buildFullWidthSection(_buildInsightsSection(primaryColor, contentColor, cardBackgroundColor)),
          const SizedBox(height: 20),
          _buildFullWidthSection(_buildSettingsSection(primaryColor, contentColor, cardBackgroundColor)),
          const SizedBox(height: 20),
          _buildFullWidthSection(_buildAccountSection(primaryColor, contentColor, cardBackgroundColor)),
          const SizedBox(height: 20),
          _buildFooterSection(contentColor), // 将版权和备案号放在底部，并使其可以滚动
          const SizedBox(height: 60), // 保留底部60的安全距离
        ],
      ),
    );
  }

  Widget _buildFullWidthSection(Widget child) {
    return SizedBox(
      width: double.infinity,
      child: child,
    );
  }

  Widget _buildProfileHeaderSection(Color primaryColor, Color textColor, Color cardBackgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: primaryColor,
            child: const Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '心灵昵称',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 10),
          Text(
            '您的心理健康伙伴',
            style: TextStyle(fontSize: 16, color: textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsSection(Color primaryColor, Color contentColor, Color cardBackgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '心灵洞察',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(height: 10),
          Text(
            '根据您的心理状态，我们建议您每天进行至少10分钟的冥想练习，以帮助减轻压力，提升心灵的平衡。',
            style: TextStyle(fontSize: 16, color: contentColor),
          ),
          const SizedBox(height: 10),
          Text(
            '您的情绪波动较大，建议保持良好的睡眠习惯，并记录每日心情，以便了解情绪变化规律。',
            style: TextStyle(fontSize: 16, color: contentColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(Color primaryColor, Color contentColor, Color cardBackgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '设置',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(height: 10),
          _buildSettingItem('通知', Icons.notifications, contentColor),
          const Divider(),
          _buildSettingItem('隐私', Icons.lock, contentColor),
          const Divider(),
          _buildSettingItem('帮助与支持', Icons.help, contentColor),
          const Divider(),
          _buildSettingItem('数据分析', Icons.analytics, contentColor),
        ],
      ),
    );
  }

  Widget _buildAccountSection(Color primaryColor, Color contentColor, Color cardBackgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '账号设置',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(height: 10),
          _buildSettingItem('个人资料', Icons.person_outline, contentColor),
          const Divider(),
          _buildSettingItem('账号安全', Icons.security, contentColor),
          const Divider(),
          _buildSettingItem('外观设置', Icons.format_paint, contentColor),
          const Divider(),
          _buildSettingItem('音色设置', Icons.music_note, contentColor),
          const Divider(),
          _buildSettingItem('关于我们', Icons.info, contentColor),
        ],
      ),
    );
  }

  Widget _buildFooterSection(Color contentColor) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16), // 保留底部16的安全距离
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '© 2024 心灵顾问 版权所有',
            style: TextStyle(fontSize: 14, color: contentColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            '备案号：ICP 12345678',
            style: TextStyle(fontSize: 14, color: contentColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String label, IconData icon, Color contentColor) {
    return Row(
      children: [
        Icon(
          icon,
          color: contentColor,
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: contentColor),
        ),
      ],
    );
  }
}