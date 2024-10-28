import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlfz/styles/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<PsychologyKnowledge> knowledgeList = [
    PsychologyKnowledge(
      title: '如何管理焦虑情绪？',
      description: '学会识别和理解焦虑的来源，掌握有效的应对策略，帮助自己更好地应对生活中的压力与挑战。',
      imageUrl: 'https://picsum.photos/200/150?random=1',
    ),
    PsychologyKnowledge(
      title: '如何管理焦虑情绪？',
      description: '学会识别和理解焦虑的来源，掌握有效的应对策略，帮助自己更好地应对生活中的压力与挑战。',
      imageUrl: 'https://picsum.photos/200/150?random=2',
    ),
    PsychologyKnowledge(
      title: '如何管理焦虑情绪？',
      description: '学会识别和理解焦虑的来源，掌握有效的应对策略，帮助自己更好地应对生活中的压力与挑战。',
      imageUrl: 'https://picsum.photos/200/150?random=3',
    ),
    PsychologyKnowledge(
      title: '如何管理焦虑情绪？',
      description: '学会识别和理解焦虑的来源，掌握有效的应对策略，帮助自己更好地应对生活中的压力与挑战。',
      imageUrl: 'https://picsum.photos/200/150?random=4',
    ),
  ];

  final List<PsychologyKnowledge> testList = [
    PsychologyKnowledge(
      title: '人格类型测试',
      description: '通过这个人格测试，了解自己的性格类型及其独特的优缺点，帮助你更好地了解自己在生活中的行为模',
      imageUrl: 'https://picsum.photos/200/150?random=11',
    ),
    PsychologyKnowledge(
      title: '人格类型测试',
      description: '通过这个人格测试，了解自己的性格类型及其独特的优缺点，帮助你更好地了解自己在生活中的行为模',
      imageUrl: 'https://picsum.photos/200/150?random=12',
    ),
    PsychologyKnowledge(
      title: '人格类型测试',
      description: '通过这个人格测试，了解自己的性格类型及其独特的优缺点，帮助你更好地了解自己在生活中的行为模',
      imageUrl: 'https://picsum.photos/200/150?random=13',
    ),
    PsychologyKnowledge(
      title: '人格类型测试',
      description: '通过这个人格测试，了解自己的性格类型及其独特的优缺点，帮助你更好地了解自己在生活中的行为模',
      imageUrl: 'https://picsum.photos/200/150?random=14',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '心理健康助手',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: appStyle.backgroundColor,
        border: Border.all(color: Colors.transparent),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(
                    appStyle.primaryColor, appStyle.accentColor),
                const SizedBox(height: 20),
                _buildCategoryGrid(appStyle),
                const SizedBox(height: 20),
                _buildPsychologyTestSection(appStyle),
                const SizedBox(height: 20),
                _buildKnowledgeSection(appStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(Color primaryColor, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withOpacity(0.5), accentColor.withOpacity(0.5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.mood,
                color: accentColor,
                size: 40,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '欢迎来到心理健康助手',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '保持内心的平静，对自己温柔一些。每天给自己一点独处的时间。',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid(AppStyle appStyle) {
    final categories = [
      {'title': '压力管理', 'icon': Icons.psychology},
      {'title': '情绪调节', 'icon': Icons.favorite},
      {'title': '睡眠质量', 'icon': Icons.bed},
      {'title': '情绪调节', 'icon': Icons.favorite},
      {'title': '睡眠质量', 'icon': Icons.bed},
      // ... 其他类别
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return _buildCategoryTile(
          appStyle,
          categories[index]['title'] as String,
          categories[index]['icon'] as IconData,
        );
      },
    );
  }

  Widget _buildCategoryTile(AppStyle appStyle, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement category-specific navigation or action
      },
      child: Container(
        decoration: BoxDecoration(
          color: appStyle.cardBackgroundColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: appStyle.primaryColor,
              size: 20,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: appStyle.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPsychologyTestSection(AppStyle appStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '心理测试',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: appStyle.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: testList.length,
          itemBuilder: (context, index) {
            return _buildTestCard(
              title: testList[index].title,
              content: testList[index].description,
              imageUrl: testList[index].imageUrl,
              backgroundColor: appStyle.cardBackgroundColor,
              titleColor: appStyle.primaryColor,
              contentColor: appStyle.textColor,
              onTap: () {
                // TODO: Implement navigation to the test details
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTestCard({
    required String title,
    required String content,
    required String imageUrl,
    required Color backgroundColor,
    required Color titleColor,
    required Color contentColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
              ),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 16,
                        color: contentColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKnowledgeSection(AppStyle appStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '心理小知识',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: appStyle.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: knowledgeList.length,
          itemBuilder: (context, index) {
            return _buildKnowledgeCard(
              appStyle,
              knowledgeList[index],
            );
          },
        ),
      ],
    );
  }

  Widget _buildKnowledgeCard(AppStyle appStyle, PsychologyKnowledge knowledge) {
    return GestureDetector(
      onTap: () {
        // TODO: 添加心理知识的详情页导航
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: appStyle.cardBackgroundColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
              ),
              child: Image.network(
                knowledge.imageUrl,
                width: 100,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      knowledge.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: appStyle.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      knowledge.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: appStyle.textColor,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PsychologyKnowledge {
  final String title;
  final String description;
  final String imageUrl;

  PsychologyKnowledge({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}
