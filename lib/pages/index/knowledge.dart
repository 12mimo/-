import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/sys.dart';

class MentalHealthKnowledgePage extends StatelessWidget {
  const MentalHealthKnowledgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // 添加渐变背景
      backgroundColor: CupertinoColors.systemBackground,
      child: Stack(
        children: [
          // 渐变背景容器
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE0F7FA),
                  Color(0xFFB2EBF2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // 内容部分
          Column(
            children: [
              CupertinoNavigationBar(
                leading: GestureDetector(
                  onTap: () => goBack(context),
                  child: const Icon(
                    CupertinoIcons.back,
                    color: CupertinoColors.activeBlue,
                  ),
                ),
                middle: const Text(
                  '心理知识',
                  style: TextStyle(
                    color: CupertinoColors.activeBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                backgroundColor: Colors.transparent,
                border: null,
              ),
              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListView(
                    children: const [
                      KnowledgeCard(
                        title: '心理健康的重要性',
                        content:
                        '心理健康对于保持身心平衡和幸福感至关重要。它帮助我们应对压力，保持积极的人际关系，并在工作和生活中实现自我价值。',
                        imageUrl: 'https://cunqa.com/static/spa/banner-1.jpeg',
                      ),
                      KnowledgeCard(
                        title: '常见心理问题',
                        content:
                        '常见的心理问题包括焦虑症、抑郁症、强迫症等。这些问题可能会影响日常生活，但通过适当的治疗和支持，可以得到有效管理。',
                        imageUrl: 'https://cunqa.com/static/spa/banner-2.jpeg',
                      ),
                      KnowledgeCard(
                        title: '如何应对压力',
                        content:
                        '应对压力的方法有很多，比如保持规律的运动、进行冥想练习、与信任的人交流等。找到适合自己的方式尤为重要。',
                        imageUrl: 'https://cunqa.com/static/spa/banner-1.jpeg',
                      ),
                      KnowledgeCard(
                        title: '寻求专业帮助',
                        content:
                        '如果您感觉到心理上的不适且难以应对，不要犹豫，及时寻求专业心理咨询师的帮助，这是对自己健康负责任的表现。',
                        imageUrl: 'https://cunqa.com/static/spa/banner-2.jpeg',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class KnowledgeCard extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  const KnowledgeCard({
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoCard(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          // 添加图片
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
            child: Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.label,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 17.0,
                    color: CupertinoColors.secondaryLabel,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CupertinoCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;

  const CupertinoCard({required this.child, this.margin = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: margin,
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.1),
            blurRadius: 15.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
