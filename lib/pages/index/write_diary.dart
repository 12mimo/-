import 'package:flutter/cupertino.dart';
import 'package:xlfz/pages/index/write_detail.dart';

class EmotionPage extends StatelessWidget {
  final String date;
  final Function(String) onSave;

  EmotionPage({required this.date, required this.onSave});

  final List<Map<String, dynamic>> emotions = [
    {'label': '满足', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemBlue, darkColor: CupertinoColors.systemBlue)},
    {'label': '快乐到起飞', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemOrange, darkColor: CupertinoColors.systemOrange)},
    {'label': 'emo', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemBlue, darkColor: CupertinoColors.systemBlue)},
    {'label': '孤独', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemGrey, darkColor: CupertinoColors.systemGrey)},
    {'label': '自信满满', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemOrange, darkColor: CupertinoColors.systemOrange)},
    {'label': '平静', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemGrey, darkColor: CupertinoColors.systemGrey)},
    {'label': '哈嘴上提', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemOrange, darkColor: CupertinoColors.systemOrange)},
    {'label': '悦意', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemRed, darkColor: CupertinoColors.systemRed)},
    {'label': '委屈', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemGrey, darkColor: CupertinoColors.systemGrey)},
    {'label': 'Chill', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemOrange, darkColor: CupertinoColors.systemOrange)},
    {'label': '失眠', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemGrey, darkColor: CupertinoColors.systemGrey)},
    {'label': '悲伤', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemBlue, darkColor: CupertinoColors.systemBlue)},
    {'label': '焦虑', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemGrey, darkColor: CupertinoColors.systemGrey)},
    {'label': '乏憾', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemRed, darkColor: CupertinoColors.systemRed)},
    {'label': '气愤', 'color': CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemRed, darkColor: CupertinoColors.systemRed)},
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back, color: CupertinoColors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        middle: Text(
          '今天心情怎么样',
          style: TextStyle(color: CupertinoColors.black),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: emotions.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onSave(emotions[index]['label']);
                Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => DiaryPage()),
                );
              },
              child: EmotionItem(
                label: emotions[index]['label'],
                color: emotions[index]['color'],
              ),
            );
          },
        ),
      ),
    );
  }
}

class EmotionItem extends StatelessWidget {
  final String label;
  final Color color;

  const EmotionItem({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: CupertinoColors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
