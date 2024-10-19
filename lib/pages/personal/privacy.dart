import 'package:flutter/cupertino.dart';

import '../../styles/color.dart';
import '../../styles/index.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          '隐私设置',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: appStyle.backgroundColor,
      ),
      child: CupertinoScrollbar(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildFullWidthSection(_buildPrivacySettingsSection(
                appStyle.primaryColor,
                appStyle.contentColor,
                appStyle.cardBackgroundColor,
                context)),
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
          _buildSettingItem('个人信息访问权限', CupertinoIcons.eye, contentColor,
              context, PersonalInfoAccessPage()),
          const SizedBox(height: 10),
          _buildSettingItem('数据共享与分析', CupertinoIcons.share, contentColor,
              context, DataSharingPage()),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String label, IconData icon, Color contentColor,
      BuildContext context, Widget? page) {
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

class PersonalInfoAccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          '个人信息访问权限',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: appStyle.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: appStyle.cardBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '个人信息访问权限设置',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: appStyle.primaryColor),
              ),
              const SizedBox(height: 10),
              Text(
                '您可以管理哪些应用或服务可以访问您的个人信息，例如联系人、相册和位置数据。请谨慎选择，以确保您的隐私安全。',
                style: TextStyle(fontSize: 16, color: appStyle.contentColor),
              ),
              const SizedBox(height: 20),
              _buildAccessSwitch('访问联系人', appStyle),
              const SizedBox(height: 10),
              _buildAccessSwitch('访问相册', appStyle),
              const SizedBox(height: 10),
              _buildAccessSwitch('访问位置数据', appStyle),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccessSwitch(String label, AppStyle appStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: appStyle.contentColor),
        ),
        CupertinoSwitch(
          value: true,
          onChanged: (bool value) {},
          activeColor: appStyle.primaryColor,
        ),
      ],
    );
  }
}

class DataSharingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          '数据共享与分析',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: appStyle.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: appStyle.cardBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '数据共享与分析设置',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: appStyle.primaryColor),
              ),
              const SizedBox(height: 10),
              Text(
                '您可以选择是否允许我们共享您的使用数据，以帮助我们改进服务并向您提供个性化的体验。',
                style: TextStyle(fontSize: 16, color: appStyle.contentColor),
              ),
              const SizedBox(height: 20),
              _buildDataSharingSwitch('允许共享使用数据', appStyle),
              const SizedBox(height: 10),
              _buildDataSharingSwitch('允许个性化分析', appStyle),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataSharingSwitch(String label, AppStyle appStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: appStyle.contentColor),
        ),
        CupertinoSwitch(
          value: true,
          onChanged: (bool value) {},
          activeColor: appStyle.primaryColor,
        ),
      ],
    );
  }
}
