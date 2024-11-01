import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:xlfz/pages/personal/about.dart';
import 'package:xlfz/pages/personal/privacy.dart';
import 'package:xlfz/pages/personal/profile_page.dart';
import '../../store/global.dart';
import '../../styles/color.dart';
import '../login/login.dart';
import 'account_security.dart';
import 'help.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = context.watch<GlobalState>().login;
    final appStyle = AppStyle(context);

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '个人中心',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: appStyle.backgroundColor,
      ),
      child: CupertinoScrollbar(
        controller: _scrollController,
        thickness: 6.0,
        radius: const Radius.circular(10),
        thumbVisibility: true,
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: 5,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return _buildFullWidthSection(_buildProfileHeaderSection(
                    appStyle.primaryColor,
                    appStyle.textColor,
                    appStyle.cardBackgroundColor));
              case 1:
                return _buildFullWidthSection(_buildInsightsSection(
                    appStyle.primaryColor,
                    appStyle.contentColor,
                    appStyle.cardBackgroundColor));
              case 2:
                return _buildFullWidthSection(_buildSettingsAndAccountSection(
                    isLoggedIn,
                    appStyle.primaryColor,
                    appStyle.contentColor,
                    appStyle.cardBackgroundColor));
              case 3:
                if (!isLoggedIn) {
                  return _buildLoginButton(appStyle.primaryColor);
                }
                return const SizedBox.shrink();
              case 4:
                return _buildFooterSection(appStyle.contentColor);
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildFullWidthSection(Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
        width: double.infinity,
        child: child,
      ),
    );
  }

  Widget _buildProfileHeaderSection(
      Color primaryColor, Color textColor, Color cardBackgroundColor) {
    Map<String, dynamic> user =
        (context.watch<GlobalState>().user as Map).cast<String, dynamic>();
    bool isLoggedIn = context.watch<GlobalState>().login;
    return _buildCardContainer(
      cardBackgroundColor,
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: user['avatar'] != null &&
                      (user['avatar'] as String).isNotEmpty
                  ? Image.network(
                      user['avatar'],
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        CupertinoIcons.person_solid,
                        size: 60,
                        color: CupertinoColors.white,
                      ),
                    )
                  : Icon(
                      CupertinoIcons.person_solid,
                      size: 60,
                      color: CupertinoColors.white,
                    ),
            ),
          ),
          const SizedBox(height: 20),
          Text("${user['nickname'] ?? '未知用户'}",
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: textColor)),
        ],
      ),
    );
  }

  Widget _buildInsightsSection(
      Color primaryColor, Color contentColor, Color cardBackgroundColor) {
    return _buildCardContainer(
      cardBackgroundColor,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('心灵洞察',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor)),
          const SizedBox(height: 10),
          Text('根据您的心理状态，我们建议您每天进行至少・30分钟的净心练习，以作为再生的灵力支持。',
              style: TextStyle(fontSize: 16, color: contentColor)),
        ],
      ),
    );
  }

  Widget _buildSettingsAndAccountSection(bool isLoggedIn, Color primaryColor,
      Color contentColor, Color cardBackgroundColor) {
    return _buildCardContainer(
      cardBackgroundColor,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLoggedIn)
            _buildSettingItem(
              '个人信息',
              CupertinoIcons.person,
              contentColor,
              const PersonalInfoPage(),
            ),
          if (isLoggedIn)
            _buildSettingItem(
              '账号安全',
              CupertinoIcons.shield,
              contentColor,
              const AccountSecurityPage(),
            ),
          // _buildSettingItem(
          //     '隐私设置', CupertinoIcons.lock, contentColor, const PrivacyPage()),
          _buildSettingItem('帮助与支持', CupertinoIcons.question_circle,
              contentColor, const HelpSupportPage()),
          _buildSettingItem(
              '关于我们', CupertinoIcons.info, contentColor, const AboutUsPage()),
        ],
      ),
    );
  }

  Widget _buildLoginButton(Color primaryColor) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      color: primaryColor,
      onPressed: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => LoginPage()));
      },
      child: const Text('登录'),
    );
  }

  Widget _buildFooterSection(Color contentColor) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('© 2024 上海天乙鑫科技有限公司 版权所有',
              style: TextStyle(fontSize: 14, color: contentColor),
              textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text('备案号：沪ICP备2022034017号',
              style: TextStyle(fontSize: 14, color: contentColor),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
      String label, IconData icon, Color contentColor, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: contentColor),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(fontSize: 16, color: contentColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildCardContainer(Color backgroundColor, Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
