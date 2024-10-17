import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/index.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final primaryColor = isDarkMode ? AppColors.darkPrimaryColor : AppColors.lightPrimaryColor;
    final backgroundColor =
    isDarkMode ? AppColors.darkBackgroundColor : AppColors.lightBackgroundColor;
    final contentColor = isDarkMode ? AppColors.darkContentColor : AppColors.lightContentColor;
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
          '个人资料',
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
                _buildPersonalInfoSection(primaryColor, contentColor, cardBackgroundColor, context)),
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

  Widget _buildPersonalInfoSection(Color primaryColor, Color contentColor,
      Color cardBackgroundColor, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: cardBackgroundColor,
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSettingItemWithData('头像', CupertinoIcons.person_crop_circle, contentColor, 'assets/avatar.png', context, null),
          const Divider(height: 20, thickness: 1),
          _buildSettingItemWithData('昵称', CupertinoIcons.person, contentColor, '心灵旅者', context, null),
          const Divider(height: 20, thickness: 1),
          _buildSettingItemWithData('性别', CupertinoIcons.person_2, contentColor, '男', context, null),
          const Divider(height: 20, thickness: 1),
          _buildSettingItemWithData('出生日期', CupertinoIcons.calendar, contentColor, '1990-01-01', context, null),
          const Divider(height: 20, thickness: 1),
          _buildSettingItemWithData('手机号', CupertinoIcons.phone, contentColor, '13800138000', context, null),
          const Divider(height: 20, thickness: 1),
          _buildSettingItemWithData('邮箱', CupertinoIcons.mail, contentColor, 'user@example.com', context, null),
        ],
      ),
    );
  }

  Widget _buildSettingItemWithData(
      String label, IconData icon, Color contentColor, String data, BuildContext context, Widget? page) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: contentColor,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 16, color: contentColor),
              ),
            ),
            Text(
              data,
              style: TextStyle(fontSize: 16, color: contentColor),
            ),
          ],
        ),
      ),
    );
  }
}