import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  String _selectedWeather = '晴天'; // 默认天气
  Color _dateColor = CupertinoColors.black; // 日期默认颜色
  Color _dateBackgroundColor = CupertinoColors.white; // 日期背景颜色

  // 天气选择列表
  final List<String> _weatherOptions = ['晴天', '阴天', '雨天', '雪天'];

  void _updateWeather(int index) {
    setState(() {
      _selectedWeather = _weatherOptions[index];
      // 根据选择的天气更改日期的样式
      switch (_selectedWeather) {
        case '晴天':
          _dateColor = CupertinoColors.systemYellow;
          _dateBackgroundColor = CupertinoColors.white;
          break;
        case '阴天':
          _dateColor = CupertinoColors.systemGrey;
          _dateBackgroundColor = CupertinoColors.white;
          break;
        case '雨天':
          _dateColor = CupertinoColors.activeBlue;
          _dateBackgroundColor = CupertinoColors.systemGrey6;
          break;
        case '雪天':
          _dateColor = CupertinoColors.systemBlue;
          _dateBackgroundColor = CupertinoColors.systemGrey4;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          child: Icon(CupertinoIcons.back),
          onTap: () => Navigator.of(context).pop(),
        ),
        middle: Text('2024 October 24'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('就这样'),
          onPressed: () {
            // 提交操作
          },
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              // 用户头像和名称部分
              Row(
                children: [
                  CircleAvatar(
                    radius: 24.0,
                    backgroundColor: CupertinoColors.systemBlue,
                    child: Icon(CupertinoIcons.smiley, color: CupertinoColors.white),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '满足',
                    style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: SizedBox()), // 占位符，右侧对齐
                  // 日期部分，右侧显示
                  Container(
                    color: _dateBackgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      '2024年10月24日',
                      style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: _dateColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              // 天气选择器
              Text('选择天气:'),
              SizedBox(height: 8.0),
              CupertinoPicker(
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {
                  _updateWeather(index);
                },
                children: _weatherOptions.map((String weather) {
                  return Center(child: Text(weather));
                }).toList(),
              ),
              SizedBox(height: 16.0),
              // 图片按钮部分
              Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.photo_camera),
                      SizedBox(width: 4.0),
                      Text('配张图片'),
                    ],
                  ),
                  onPressed: () {
                    // 处理图片选择
                  },
                ),
              ),
              SizedBox(height: 16.0),
              // 生成金句提示文本
              Text(
                '不知道写什么？ 一键生成金句',
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              // 提示用户输入的文本
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '发生了什么事，让你有这样的心情呢？来讲讲吧...',
                  style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                    fontSize: 14.0,
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // 输入框部分
              CupertinoTextField(
                placeholder: '在这里写下你的想法...',
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                maxLines: 5,
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  border: Border.all(color: CupertinoColors.systemGrey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
