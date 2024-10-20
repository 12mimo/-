import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MentalHealthKnowledgePage extends StatelessWidget {
  const MentalHealthKnowledgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('心理知识'),
        backgroundColor: CupertinoColors.systemBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            KnowledgeCard(
              title: '心理健康的重要性',
              content:
                  '心理健康对于保持身心平衡和幸福感至关重要。它帮助我们应对压力，保持积极的人际关系，并在工作和生活中实现自我价值。',
            ),
            KnowledgeCard(
              title: '常见心理问题',
              content:
                  '常见的心理问题包括焦虑症、抑郁症、强迫症等。这些问题可能会影响日常生活，但通过适当的治疗和支持，可以得到有效管理。',
            ),
            KnowledgeCard(
              title: '如何应对压力',
              content: '应对压力的方法有很多，比如保持规律的运动、进行冥想练习、与信任的人交流等。找到适合自己的方式尤为重要。',
            ),
            KnowledgeCard(
              title: '寻求专业帮助',
              content: '如果您感觉到心理上的不适且难以应对，不要犹豫，及时寻求专业心理咨询师的帮助，这是对自己健康负责任的表现。',
            ),
          ],
        ),
      ),
    );
  }
}

class KnowledgeCard extends StatelessWidget {
  final String title;
  final String content;

  const KnowledgeCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return CupertinoCard(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.label,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16.0,
                color: CupertinoColors.secondaryLabel,
              ),
            ),
          ],
        ),
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
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
