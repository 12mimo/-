import 'package:flutter/cupertino.dart';

import '../../styles/color.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: appStyle.backgroundColor,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          '关于我们',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCompanyInfoSection(appStyle.primaryColor,
                  appStyle.textColor, appStyle.cardBackgroundColor),
              const SizedBox(height: 20),
              _buildFooterSection(appStyle.contentColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyInfoSection(
      Color primaryColor, Color textColor, Color cardBackgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '公司介绍',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(height: 10),
          Text(
            '上海天乙鑫科技有限公司致力于通过智能技术提供个性化的心理健康支持。我们将先进的人工智能与心理学相结合，帮助用户更好地理解自己，提升心理健康水平。',
            style: TextStyle(fontSize: 16, color: textColor),
          ),
          const SizedBox(height: 10),
          Text(
            '公司还积极与各大高校和科研机构合作，不断探索心理健康和人工智能领域的最新发展，致力于将最前沿的科技成果应用于我们的产品中，以确保用户能够获得最科学和有效的心理健康支持。',
            style: TextStyle(fontSize: 16, color: textColor),
          ),
          const SizedBox(height: 10),
          Text(
            '此外，我们的产品还具备丰富的社交功能，旨在为用户搭建一个支持性社区，让用户在交流中获得他人的帮助和启发。公司非常重视用户隐私与数据安全，采取了多项严格的措施来保护用户的个人信息，确保数据在传输和存储过程中的安全性。我们坚信，通过科学技术与人文关怀的结合，可以帮助每一个人获得更好的心理健康支持。',
            style: TextStyle(fontSize: 16, color: textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSection(Color contentColor) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '© 2024 上海天乙鑫科技有限公司 版权所有',
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
}
