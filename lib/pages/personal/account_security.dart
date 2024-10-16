import 'package:flutter/cupertino.dart';
import '../login/login.dart'; // 确保导入的路径正确

class AccountSecurityPage extends StatelessWidget {
  const AccountSecurityPage({super.key});

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
    isDarkMode ? const Color(0xFF455A64) : const Color(0xFFE0F7FA);

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
                _buildAccountSafetySection(primaryColor, contentColor, cardBackgroundColor, context)),
            const SizedBox(height: 20),
            _buildLoginButton(context, primaryColor),
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

  Widget _buildAccountSafetySection(Color primaryColor, Color contentColor,
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
            '账号安全设置',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(height: 10),
          _buildSettingItem('修改密码', CupertinoIcons.lock_shield, contentColor, context, null),
          const SizedBox(height: 10),
          _buildSettingItem('绑定手机', CupertinoIcons.phone, contentColor, context, null),
          const SizedBox(height: 10),
          _buildSettingItem('绑定邮箱', CupertinoIcons.mail, contentColor, context, null),
          const SizedBox(height: 10),
          _buildSettingItem('登录历史', CupertinoIcons.time, contentColor, context, null),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, Color primaryColor) {
    return CupertinoButton(
      color: primaryColor,
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const LoginPage()),
        );
      },
      child: const Text('登录'),
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