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
      title: '提升自尊的五个技巧',
      description: '自尊是心理健康的重要基础，了解如何通过实际的步骤来增强自尊，让自己更加自信和积极。',
      imageUrl: 'https://picsum.photos/200/150?random=2',
    ),
    PsychologyKnowledge(
      title: '什么是情绪调节？如何做到情绪调节？',
      description: '探索情绪调节的核心概念，学习有效的方法来处理情绪波动，减少情绪对生活的负面影响。',
      imageUrl: 'https://picsum.photos/200/150?random=3',
    ),
    PsychologyKnowledge(
      title: '孤独感的成因及应对方法',
      description: '了解孤独感的心理机制，如何识别并面对孤独感，以及培养积极社交关系的具体步骤。',
      imageUrl: 'https://picsum.photos/200/150?random=4',
    ),
    PsychologyKnowledge(
      title: '压力管理：有效的减压方法',
      description: '压力是生活中的常客，学习几种简单而有效的减压方法，帮助你更轻松地面对生活中的挑战。',
      imageUrl: 'https://picsum.photos/200/150?random=5',
    ),
    PsychologyKnowledge(
      title: '心理韧性：如何在逆境中成长',
      description: '心理韧性是指面对困境时的恢复力和应对能力，了解如何培养这一重要品质，让自己在逆境中成长。',
      imageUrl: 'https://picsum.photos/200/150?random=6',
    ),
    PsychologyKnowledge(
      title: '如何识别并应对职场倦怠？',
      description: '职场倦怠对心理健康影响巨大，学会识别倦怠的迹象，以及有效的调适方法来恢复精力和动力。',
      imageUrl: 'https://picsum.photos/200/150?random=7',
    ),
    PsychologyKnowledge(
      title: '抑郁的早期症状与自助方法',
      description: '了解抑郁的早期症状，如何识别这些信号，以及通过简单的方法自助，以防止问题恶化。',
      imageUrl: 'https://picsum.photos/200/150?random=8',
    ),
    PsychologyKnowledge(
      title: '积极心理学：如何培养幸福感？',
      description: '积极心理学倡导通过培养积极情绪和良好习惯来提升幸福感，学会让自己在生活中保持愉悦的心境。',
      imageUrl: 'https://picsum.photos/200/150?random=9',
    ),
    PsychologyKnowledge(
      title: '如何构建健康的人际关系？',
      description: '人际关系对心理健康至关重要，探索如何通过有效的沟通和共情，建立并维持健康而稳定的关系。',
      imageUrl: 'https://picsum.photos/200/150?random=10',
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
      {'title': '社交焦虑', 'icon': Icons.group},
      {'title': '工作压力', 'icon': Icons.work},
      {'title': '自我认知', 'icon': Icons.person},
      {'title': '亲密关系', 'icon': Icons.favorite_border},
      {'title': '成瘾行为', 'icon': Icons.local_bar},
      {'title': '抑郁症状', 'icon': Icons.sentiment_dissatisfied},
      {'title': '正念冥想', 'icon': Icons.self_improvement},
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
            appStyle, categories[index]['title'] as String,
            categories[index]['icon'] as IconData);
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
              size: 30,
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

  final List<PsychologyKnowledge> testList = [
    PsychologyKnowledge(
      title: '人格类型测试：了解真正的自己',
      description: '通过这个人格测试，了解自己的性格类型及其独特的优缺点，帮助你更好地了解自己在生活中的行为模式。',
      imageUrl: 'https://picsum.photos/200/150?random=11',
    ),
    PsychologyKnowledge(
      title: '情绪智商（EQ）测试：掌握情绪的钥匙',
      description: '测试你的情绪智商，了解自己在情绪感知、管理和表达上的能力，学会在社交和生活中更好地控制情绪。',
      imageUrl: 'https://picsum.photos/200/150?random=12',
    ),
    PsychologyKnowledge(
      title: '压力水平评估：找出你的压力源',
      description: '通过这份测试，快速评估你目前的压力水平，并找出导致压力的主要因素，从而制定相应的减压策略。',
      imageUrl: 'https://picsum.photos/200/150?random=12',
    ),
    PsychologyKnowledge(
      title: '幸福感指数测试：你有多快乐？',
      description: '测量你的幸福感指数，了解影响你幸福感的因素，学习如何提高生活满意度和心理上的幸福感。',
      imageUrl: 'https://picsum.photos/200/150?random=12',
    ),
    PsychologyKnowledge(
      title: '社交焦虑自评量表：社交场合中的你',
      description: '通过这份社交焦虑测试，评估你在社交场合中的舒适度和焦虑程度，找到提升社交信心的方法。',
      imageUrl: 'https://picsum.photos/200/150?random=12',
    ),
    PsychologyKnowledge(
      title: '睡眠质量心理测试：你的睡眠还好吗？',
      description: '测试你的睡眠质量，了解睡眠对心理健康的影响，并获得提升睡眠质量的建议，让你拥有更健康的生活状态。',
      imageUrl: 'https://picsum.photos/200/150?random=12',
    ),
  ];
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
                height: 100,
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
          '心理知识',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: appStyle.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.8,
          ),
          itemCount: knowledgeList.length,
          itemBuilder: (context, index) {
            return _buildKnowledgeTile(appStyle, knowledgeList[index]);
          },
        ),
      ],
    );
  }

  Widget _buildKnowledgeTile(AppStyle appStyle, PsychologyKnowledge knowledge) {
    return GestureDetector(
      onTap: () {
        // TODO: 添加心理知识的详情页导航
      },
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: Image.network(
                knowledge.imageUrl,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
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
