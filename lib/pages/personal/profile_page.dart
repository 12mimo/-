import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final primaryColor =
    isDarkMode ? const Color(0xFF80CBC4) : const Color(0xFF00838F);
    final backgroundColor =
    isDarkMode ? const Color(0xFF37474F) : const Color(0xFFB2EBF2);
    final textColor =
    isDarkMode ? const Color(0xFFCFD8DC) : const Color(0xFF546E7A);
    final contentColor =
    isDarkMode ? const Color(0xFFB0BEC5) : const Color(0xFF455A64);
    final cardBackgroundColor =
    isDarkMode ? const Color(0xFF455A64) : primaryColor.withOpacity(0.1);

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
            color: Colors.black.withOpacity(0.1),
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