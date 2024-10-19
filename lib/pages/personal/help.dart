import 'package:flutter/cupertino.dart';

import '../../styles/color.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

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
          '帮助与支持',
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
            _buildFullWidthSection(_buildHelpSupportSection(
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

  Widget _buildHelpSupportSection(Color primaryColor, Color contentColor,
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
            '帮助与支持',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(height: 10),
          _buildSettingItem('常见问题解答', CupertinoIcons.question_circle,
              contentColor, context, FAQListPage()),
          const SizedBox(height: 10),
          _buildSettingItem('联系客服', CupertinoIcons.phone, contentColor, context,
              ContactUsPage()),
          const SizedBox(height: 10),
          _buildSettingItem('反馈问题', CupertinoIcons.chat_bubble, contentColor,
              context, FeedbackPage()),
          const SizedBox(height: 10),
          _buildSettingItem('使用指南', CupertinoIcons.book, contentColor, context,
              UserGuidePage()),
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

class FAQListPage extends StatelessWidget {
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
        middle: Text('常见问题解答', style: TextStyle(color: appStyle.primaryColor)),
        backgroundColor: appStyle.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: 5, // Example number of FAQ items
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => FAQDetailPage(index: index)),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: appStyle.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '问题 ${index + 1}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: appStyle.primaryColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FAQDetailPage extends StatelessWidget {
  final int index;

  FAQDetailPage({required this.index});

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
        middle: Text('问题 ${index + 1}',
            style: TextStyle(color: appStyle.primaryColor)),
        backgroundColor: appStyle.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '问题 ${index + 1}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: appStyle.primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '这是问题 ${index + 1} 的答案，帮助您更好地使用应用程序。',
              style: TextStyle(fontSize: 16, color: appStyle.contentColor),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactUsPage extends StatelessWidget {
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
        middle: Text('联系客服', style: TextStyle(color: appStyle.primaryColor)),
        backgroundColor: appStyle.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '联系客服',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: appStyle.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  CupertinoIcons.phone,
                  color: appStyle.primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  '电话：123-456-7890',
                  style: TextStyle(fontSize: 16, color: appStyle.contentColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  CupertinoIcons.mail,
                  color: appStyle.primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  '邮箱：support@example.com',
                  style: TextStyle(fontSize: 16, color: appStyle.contentColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackPage extends StatelessWidget {
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
        middle: Text('反馈问题', style: TextStyle(color: appStyle.primaryColor)),
        backgroundColor: appStyle.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '反馈问题',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: appStyle.primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '您的反馈对我们非常重要，请告诉我们您遇到的问题或建议。',
              style: TextStyle(fontSize: 16, color: appStyle.contentColor),
            ),
            const SizedBox(height: 20),
            CupertinoTextField(
              placeholder: '请输入您的反馈...',
              maxLines: 5,
              decoration: BoxDecoration(
                color: appStyle.cardBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: appStyle.primaryColor,
              minSize: 50,
              borderRadius: BorderRadius.circular(10),
              child: Center(
                child: Text('提交反馈',
                    style: TextStyle(color: CupertinoColors.white)),
              ),
              onPressed: () {
                // Handle feedback submission
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserGuidePage extends StatelessWidget {
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
        middle: Text('使用指南', style: TextStyle(color: appStyle.primaryColor)),
        backgroundColor: appStyle.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: 5, // Example number of guide items
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => UserGuideDetailPage(index: index)),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: appStyle.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '指南 ${index + 1}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: appStyle.primaryColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class UserGuideDetailPage extends StatelessWidget {
  final int index;

  UserGuideDetailPage({required this.index});

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
        middle: Text('指南 ${index + 1}',
            style: TextStyle(color: appStyle.primaryColor)),
        backgroundColor: appStyle.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '指南 ${index + 1}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: appStyle.primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '这是指南 ${index + 1} 的详细内容，帮助您更好地使用应用程序。',
              style: TextStyle(fontSize: 16, color: appStyle.contentColor),
            ),
          ],
        ),
      ),
    );
  }
}
