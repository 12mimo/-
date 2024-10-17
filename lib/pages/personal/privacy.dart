import 'package:flutter/cupertino.dart';

import '../../styles/index.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    var primaryColor = isDarkMode ? AppColors.darkPrimaryColor : AppColors.lightPrimaryColor;
    var backgroundColor =
    isDarkMode ? AppColors.darkBackgroundColor : AppColors.lightBackgroundColor;
    var contentColor = isDarkMode ? AppColors.darkContentColor : AppColors.lightContentColor;
    var cardBackgroundColor = isDarkMode ? AppColors.darkCardBackgroundColor : AppColors.lightCardBackgroundColor;

    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: primaryColor,
          ),
        ),
        middle: Text(
          '隐私设置',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      child: CupertinoScrollbar(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildFullWidthSection(
                _buildPrivacySettingsSection(primaryColor, contentColor, cardBackgroundColor, context)),
          ],
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

  Widget _buildPrivacySettingsSection(Color primaryColor, Color contentColor,
      Color cardBackgroundColor, BuildContext context) {
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
            '隐私设置',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(height: 10),
          _buildSettingItem('个人信息访问权限', CupertinoIcons.eye, contentColor, context, null),
          const SizedBox(height: 10),
          _buildSettingItem('位置服务', CupertinoIcons.location, contentColor, context, null),
          const SizedBox(height: 10),
          _buildSettingItem('广告个性化', CupertinoIcons.chart_pie, contentColor, context, null),
          const SizedBox(height: 10),
          _buildSettingItem('数据共享与分析', CupertinoIcons.share, contentColor, context, null),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
      String label, IconData icon, Color contentColor, BuildContext context, Widget? page) {
    return GestureDetector(
      onTap: () {
        if (page != null) {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => page),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
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
        ),
      ),
    );
  }
}