import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xlfz/pages/index/psychology_test.dart';
import 'package:xlfz/styles/color.dart';

import '../../utils/http.dart';
import '../consultant/test_result.dart';
import 'article_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final HttpHelper _httpHelper = HttpHelper();
  final List<PsychologyKnowledge> knowledgeList = [];

  final List<PsychologyKnowledge> testList = [];

  @override
  void initState() {
    super.initState();
    getIndexApi();
  }

  void getIndexApi() async {
    var postResponse = await _httpHelper.postRequest(
      "/",
      {},
      requireAuth: false,
    );
    if (postResponse != null &&
        postResponse['data'] != null &&
        postResponse['data']['articles'] != null) {
      setState(() {
        knowledgeList.addAll(
          (postResponse['data']['articles'] as List).map((article) {
            return PsychologyKnowledge.fromMap(article);
          }).toList(),
        );
        testList.addAll(
          (postResponse['data']['tests'] as List).map((tests) {
            return PsychologyKnowledge.fromTest(tests);
          }).toList(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '心灵方舟小助手',
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
                // _buildCategoryGrid(appStyle),
                // const SizedBox(height: 20),
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
                  '欢迎来到心灵方舟',
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
        Center(
          child: Text(
            '方舟小测验',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: appStyle.primaryColor,
            ),
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
              id: testList[index].id.toString(),
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
    required String id,
    required Color backgroundColor,
    required Color titleColor,
    required Color contentColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => PsychologyTestPage(
              title: title,
              description: content,
              id: id,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.0),
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
        Center(
          child: Text(
            '方舟小贴士',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: appStyle.primaryColor,
            ),
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
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ArticleDetailPage(
              title: knowledge.title,
              content: knowledge.content,
              author: '',
              date: '',
              id: knowledge.id,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: appStyle.cardBackgroundColor,
          borderRadius: BorderRadius.circular(16.0),
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
                        fontSize: 18,
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
  final String id;
  final String content;

  PsychologyKnowledge({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.id,
    required this.content,
  });

  // 手动添加一个工厂构造函数
  factory PsychologyKnowledge.fromMap(Map<String, dynamic> data) {
    return PsychologyKnowledge(
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      description: data['describe'] ?? '',
      imageUrl: 'https://picsum.photos/200/150?random=${data['id']}',
      id: data["id"].toString(),
    );
  }

  factory PsychologyKnowledge.fromTest(Map<String, dynamic> data) {
    return PsychologyKnowledge(
      title: data['Title'] ?? '',
      content: data['Description'] ?? '',
      description: data['Description'] ?? '',
      imageUrl: 'https://picsum.photos/200/150?random=${data['id']}',
      id: data["Id"].toString(),
    );
  }
}
