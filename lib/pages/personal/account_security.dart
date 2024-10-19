import 'package:flutter/cupertino.dart';
import 'package:xlfz/utils/sys.dart';
import '../../store/global.dart';
import '../../styles/color.dart';
import '../../utils/cache.dart';

class AccountSecurityPage extends StatelessWidget {
  const AccountSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          '账号安全',
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
            _buildFullWidthSection(
              _buildAccountSafetySection(context, appStyle.primaryColor,
                  appStyle.contentColor, appStyle.cardBackgroundColor),
            ),
            const SizedBox(height: 20),
            _buildLogoutButton(context, appStyle.primaryColor),
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

  Widget _buildAccountSafetySection(BuildContext context, Color primaryColor,
      Color contentColor, Color cardBackgroundColor) {
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
          _buildSettingItem('修改密码', CupertinoIcons.lock_shield, contentColor,
              () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                  builder: (BuildContext context) => ChangePasswordPage()),
            );
          }),
          const SizedBox(height: 10),
          _buildSettingItem('绑定手机', CupertinoIcons.phone, contentColor, () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                  builder: (BuildContext context) => BindPhonePage()),
            );
          }),
          const SizedBox(height: 10),
          _buildSettingItem('绑定邮箱', CupertinoIcons.mail, contentColor, () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                  builder: (BuildContext context) => BindEmailPage()),
            );
          }),
          const SizedBox(height: 10),
          _buildSettingItem('登录历史', CupertinoIcons.time, contentColor, () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                  builder: (BuildContext context) => LoginHistoryPage()),
            );
          }),
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

  Widget _buildSettingItem(
      String label, IconData icon, Color contentColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          '修改密码',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '请输入新密码',
              style: TextStyle(
                fontSize: 18,
                color: appStyle.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            CupertinoTextField(
              placeholder: '新密码',
              obscureText: true,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              // padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: appStyle.cardBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: appStyle.textColor.withOpacity(0.3),
                ),
              ),
            ),
            const SizedBox(height: 16),
            CupertinoTextField(
              placeholder: '确认新密码',
              obscureText: true,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              // padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: appStyle.cardBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: appStyle.textColor.withOpacity(0.3),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                color: appStyle.primaryColor,
                borderRadius: BorderRadius.circular(10),
                onPressed: () {
                  // Implement password change logic here
                },
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Text(
                  '确认修改',
                  style: TextStyle(
                    color: appStyle.backgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BindPhonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    TextEditingController phoneController = TextEditingController();

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          '绑定手机',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '请输入手机号码',
              style: TextStyle(
                fontSize: 18,
                color: appStyle.contentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            CupertinoTextField(
              controller: phoneController,
              placeholder: '手机号码',
              keyboardType: TextInputType.phone,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: appStyle.cardBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: appStyle.textColor.withOpacity(0.3),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                color: appStyle.primaryColor,
                borderRadius: BorderRadius.circular(10),
                onPressed: () {
                  // Implement phone binding logic here
                },
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Text(
                  '绑定手机',
                  style: TextStyle(
                    color: appStyle.backgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BindEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    TextEditingController emailController = TextEditingController();

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          '绑定邮箱',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '请输入邮箱地址',
              style: TextStyle(
                fontSize: 18,
                color: appStyle.contentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            CupertinoTextField(
              controller: emailController,
              placeholder: '邮箱地址',
              keyboardType: TextInputType.emailAddress,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: appStyle.cardBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: appStyle.textColor.withOpacity(0.3),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                color: appStyle.primaryColor,
                borderRadius: BorderRadius.circular(10),
                onPressed: () {
                  // Implement email binding logic here
                },
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Text(
                  '绑定邮箱',
                  style: TextStyle(
                    color: appStyle.backgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          '登录历史',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '最近登录记录',
              style: TextStyle(
                fontSize: 18,
                color: appStyle.contentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                // Example data count, replace with actual data length
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: appStyle.cardBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: appStyle.textColor.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '设备：iPhone 13',
                          // Example device, replace with actual data
                          style: TextStyle(
                            color: appStyle.textColor,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '时间：2024-10-19 10:30',
                          // Example timestamp, replace with actual data
                          style: TextStyle(
                            color: appStyle.textColor.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
