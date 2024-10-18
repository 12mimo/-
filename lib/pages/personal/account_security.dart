import 'package:flutter/cupertino.dart';
import 'package:xlfz/utils/sys.dart';
import '../../store/global.dart';
import '../../styles/index.dart';
import '../../utils/cache.dart';

class AccountSecurityPage extends StatelessWidget {
  const AccountSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final primaryColor =
        isDarkMode ? AppColors.darkPrimaryColor : AppColors.lightPrimaryColor;
    final backgroundColor = isDarkMode
        ? AppColors.darkBackgroundColor
        : AppColors.lightBackgroundColor;
    final contentColor =
        isDarkMode ? AppColors.darkContentColor : AppColors.lightContentColor;
    final cardBackgroundColor = isDarkMode
        ? AppColors.darkCardBackgroundColor
        : AppColors.lightCardBackgroundColor;

    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: primaryColor,
          ),
        ),
        middle: Text(
          '账号安全',
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
              _buildAccountSafetySection(
                  primaryColor, contentColor, cardBackgroundColor),
            ),
            const SizedBox(height: 20),
            _buildLogoutButton(context, primaryColor),
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

  Widget _buildAccountSafetySection(
      Color primaryColor, Color contentColor, Color cardBackgroundColor) {
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
            '账号安全设置',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          _buildSettingItem('修改密码', CupertinoIcons.lock_shield, contentColor),
          const SizedBox(height: 10),
          _buildSettingItem('绑定手机', CupertinoIcons.phone, contentColor),
          const SizedBox(height: 10),
          _buildSettingItem('绑定邮箱', CupertinoIcons.mail, contentColor),
          const SizedBox(height: 10),
          _buildSettingItem('登录历史', CupertinoIcons.time, contentColor),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, Color primaryColor) {
    return CupertinoButton(
      color: primaryColor,
      onPressed: () async {
        GlobalState().setLogin(false);
        await removeFromCache("token");
        goBack(context, null, true);
      },
      child: const Text('退出登录'),
    );
  }

  Widget _buildSettingItem(String label, IconData icon, Color contentColor) {
    return Padding(
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
    );
  }
}
