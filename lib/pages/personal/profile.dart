import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlfz/pages/personal/about.dart';
import 'package:xlfz/pages/personal/privacy.dart';
import 'package:xlfz/pages/personal/profile_page.dart';
import 'package:xlfz/utils/cache.dart';
import '../../styles/index.dart';
import '../login/login.dart';
import 'account_security.dart';
import 'help.dart'; // 确保导入的路径正确

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loginSign = false;

  @override
  void initState() {
    super.initState();
    _loadLoginStatus();
  }

  void _loadLoginStatus() async {
    var token = await loadFromCache("token");
    if (token == null) {
      // 没有 token，跳转到登录页面
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      setState(() {
        loginSign = true;
      });
    }
  }
  void _checkLoginStatus() async {
    var token = await loadFromCache("token");
    if (token == null) {
      // 没有 token，跳转到登录页面
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      setState(() {
        loginSign = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    _checkLoginStatus();
    var brightness = MediaQuery.of(context).platformBrightness;
    var isDarkMode = brightness == Brightness.dark;
    var primaryColor = isDarkMode ? AppColors.darkPrimaryColor : AppColors.lightPrimaryColor;
    var backgroundColor =
    isDarkMode ? AppColors.darkBackgroundColor : AppColors.lightBackgroundColor;
    var textColor = isDarkMode ? AppColors.darkTextColor : AppColors.lightTextColor;
    var contentColor = isDarkMode ? AppColors.darkContentColor : AppColors.lightContentColor;
    var cardBackgroundColor =
    isDarkMode ? AppColors.darkCardBackgroundColor : AppColors.lightCardBackgroundColor;

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
      child: CupertinoScrollbar(
        controller: PrimaryScrollController.of(context),
        thickness: 6.0,
        radius: Radius.circular(10),
        thumbVisibility: true,
        child: ListView(
          controller: PrimaryScrollController.of(context),
          padding: const EdgeInsets.all(16),
          children: [
            _buildFullWidthSection(
                _buildProfileHeaderSection(primaryColor, textColor, cardBackgroundColor)),
            const SizedBox(height: 20),
            _buildFullWidthSection(
                _buildInsightsSection(primaryColor, contentColor, cardBackgroundColor)),
            const SizedBox(height: 20),
            _buildFullWidthSection(
                _buildSettingsAndAccountSection(primaryColor, contentColor, cardBackgroundColor, context)),
            const SizedBox(height: 20),
            loginSign ? Container() : _buildLoginButton(context, primaryColor), // 增加登录按钮
            const SizedBox(height: 20),
            _buildFooterSection(contentColor), // 将版权和备案号放在底部，并使其可以滚动
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

  Widget _buildProfileHeaderSection(
      Color primaryColor, Color textColor, Color cardBackgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
            ),
            child: const Icon(
              CupertinoIcons.person_solid,
              size: 60,
              color: CupertinoColors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '心灵昵称',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 10),
          Text(
            '您的心理健康伴侣',
            style: TextStyle(fontSize: 16, color: textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsSection(
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
            '心灵洞察',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(height: 10),
          Text(
            '根据您的心理状态，我们建议您每天进行至少・30分钟的净心练习，以作为再生的灵力支持。',
            style: TextStyle(fontSize: 16, color: contentColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsAndAccountSection(Color primaryColor, Color contentColor,
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
          _buildSettingItem('个人信息', CupertinoIcons.person, contentColor, context, const PersonalInfoPage()),
          const SizedBox(height: 10),
          _buildSettingItem('账号安全', CupertinoIcons.shield, contentColor, context, const AccountSecurityPage()),
          const SizedBox(height: 10),
          _buildSettingItem('隐私', CupertinoIcons.lock, contentColor, context, const PrivacyPage()),
          const SizedBox(height: 10),
          _buildSettingItem('帮助与支持', CupertinoIcons.question_circle, contentColor, context, const HelpSupportPage()),
          const SizedBox(height: 10),
          _buildSettingItem('关于我们', CupertinoIcons.info, contentColor, context, const AboutUsPage()),
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
          CupertinoPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: const Text('登录'),
    );
  }

  Widget _buildFooterSection(Color contentColor) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '© 2024 上海天乙鑫科技有限公司 所有权利保留',
            style: TextStyle(fontSize: 14, color: contentColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            '备案号：沪ICP备2022034017号',
            style: TextStyle(fontSize: 14, color: contentColor),
            textAlign: TextAlign.center,
          ),
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
        padding: const EdgeInsets.symmetric(vertical: 12.0), // 调整行高
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
