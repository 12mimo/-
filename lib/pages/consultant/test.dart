import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlfz/pages/consultant/test_result.dart';

import '../../styles/color.dart';
// import 'results_page.dart'; // 导入结果页面

class PlaceholderPage extends StatefulWidget {
  @override
  _PlaceholderPageState createState() => _PlaceholderPageState();
}
// PsychologyTestPage
class _PlaceholderPageState extends State<PlaceholderPage> {
  final Map<int, int> _selectedOptions = {};
  int _currentQuestionIndex = 0;

  final Map<String, List<String>> _categoriesWithQuestions = {
    '社交性': [
      '您在社交场合中是否感到自在？',
      '您更喜欢独处还是与他人互动？',
    ],
    '决策方式': [
      '您是否倾向于在做决定前深思熟虑？',
    ],
    '计划性': [
      '您更喜欢计划还是随机应变？',
    ],
    '创造力': [
      '您是否觉得自己是一个富有创意的人？',
    ],
    '直觉': [
      '您是否倾向于相信直觉而不是逻辑？',
    ],
    '情感反应': [
      '您是否容易受到他人情绪的影响？',
    ],
    '问题解决': [
      '您是否喜欢解决复杂的问题？',
    ],
    '规则遵循': [
      '您是否更倾向于遵循规则和传统？',
    ],
    '冒险精神': [
      '您是否喜欢尝试新鲜事物？',
    ],
  };

  final List<List<String>> _options = [
    ['非常不自在', '有些不自在', '比较自在', '非常自在'],
    ['完全喜欢独处', '大部分时间喜欢独处', '大部分时间喜欢互动', '完全喜欢互动'],
    ['总是深思熟虑', '经常深思熟虑', '偶尔深思熟虑', '很少深思熟虑'],
    ['总是喜欢计划', '经常喜欢计划', '偶尔喜欢随机应变', '总是喜欢随机应变'],
    ['非常富有创意', '比较富有创意', '偶尔富有创意', '很少富有创意'],
    ['总是相信直觉', '经常相信直觉', '偶尔相信直觉', '很少相信直觉'],
    ['非常容易受到影响', '有些容易受到影响', '不太容易受到影响', '完全不受影响'],
    ['非常喜欢', '比较喜欢', '偶尔喜欢', '不喜欢'],
    ['非常遵循规则', '比较遵循规则', '偶尔遵循规则', '不遵循规则'],
    ['非常喜欢尝试', '比较喜欢尝试', '偶尔喜欢尝试', '不喜欢尝试'],
  ];

  // 定义每个问题所属的 MBTI 维度
  final Map<int, String> _questionDimensions = {
    0: 'EI', // 社交性
    1: 'EI', // 独处与互动
    2: 'TF', // 决策方式
    3: 'JP', // 计划性
    4: 'SN', // 创造力
    5: 'SN', // 直觉
    6: 'TF', // 情感反应
    7: 'TF', // 问题解决
    8: 'JP', // 规则遵循
    9: 'JP', // 冒险精神
  };

  // 定义每个选项对应的分数
  final List<List<Map<String, int>>> _optionScores = [
    // 问题0: 社交性
    [
      {'E': 3},
      {'E': 2},
      {'I': 2},
      {'I': 3},
    ],
    // 问题1: 独处与互动
    [
      {'I': 3},
      {'I': 2},
      {'E': 2},
      {'E': 3},
    ],
    // 问题2: 决策方式
    [
      {'T': 3},
      {'T': 2},
      {'F': 2},
      {'F': 3},
    ],
    // 问题3: 计划性
    [
      {'J': 3},
      {'J': 2},
      {'P': 2},
      {'P': 3},
    ],
    // 问题4: 创造力
    [
      {'S': 3},
      {'S': 2},
      {'N': 2},
      {'N': 3},
    ],
    // 问题5: 直觉
    [
      {'S': 3},
      {'S': 2},
      {'N': 2},
      {'N': 3},
    ],
    // 问题6: 情感反应
    [
      {'F': 3},
      {'F': 2},
      {'T': 2},
      {'T': 3},
    ],
    // 问题7: 问题解决
    [
      {'T': 3},
      {'T': 2},
      {'F': 2},
      {'F': 3},
    ],
    // 问题8: 规则遵循
    [
      {'J': 3},
      {'J': 2},
      {'P': 2},
      {'P': 3},
    ],
    // 问题9: 冒险精神
    [
      {'P': 3},
      {'P': 2},
      {'J': 2},
      {'J': 3},
    ],
  ];

  List<String> get _questions {
    return _categoriesWithQuestions.values.expand((q) => q).toList();
  }

  // 计算MBTI类型
  String _calculateMBTI() {
    Map<String, int> scores = {
      'E': 0,
      'I': 0,
      'S': 0,
      'N': 0,
      'T': 0,
      'F': 0,
      'J': 0,
      'P': 0,
    };

    _selectedOptions.forEach((questionIndex, optionIndex) {
      Map<String, int> scoreMap = _optionScores[questionIndex][optionIndex];
      scoreMap.forEach((key, value) {
        scores[key] = scores[key]! + value;
      });
    });

    String mbti = '';
    // E vs I
    mbti += scores['E']! >= scores['I']! ? 'E' : 'I';
    // S vs N
    mbti += scores['S']! >= scores['N']! ? 'S' : 'N';
    // T vs F
    mbti += scores['T']! >= scores['F']! ? 'T' : 'F';
    // J vs P
    mbti += scores['J']! >= scores['P']! ? 'J' : 'P';

    return mbti;
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: appStyle.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // 返回上一页
          },
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          'MBTI 测试页面',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // 进度指示器
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: (_currentQuestionIndex + 1) / _questions.length,
                    backgroundColor: CupertinoColors.systemGrey4,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(appStyle.primaryColor),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '第 ${_currentQuestionIndex + 1} / ${_questions.length} 题',
                    style: TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 描述
                    Text(
                      '通过回答以下问题，了解您的性格类型。每个问题都有多个选项，请选择最符合您的选项。',
                      style: TextStyle(
                        fontSize: 18,
                        color: appStyle.primaryColor,
                      ),
                    ),
                    SizedBox(height: 24),
                    // 问题部分
                    _buildQuestion(_currentQuestionIndex),
                  ],
                ),
              ),
            ),
            // 底部按钮
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                children: [
                  // 上一题按钮
                  if (_currentQuestionIndex > 0)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: CupertinoButton(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          borderRadius: BorderRadius.circular(8.0),
                          onPressed: () {
                            setState(() {
                              _currentQuestionIndex--;
                            });
                          },
                          child: Text(
                            '上一题',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (_currentQuestionIndex > 0) SizedBox(width: 16),
                  // 下一题或提交按钮
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            _selectedOptions.containsKey(_currentQuestionIndex)
                                ? appStyle.primaryColor
                                : CupertinoColors.systemGrey, // 根据按钮状态设置背景色
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: CupertinoButton(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        borderRadius: BorderRadius.circular(8.0),
                        onPressed:
                            _selectedOptions.containsKey(_currentQuestionIndex)
                                ? () {
                                    if (_currentQuestionIndex <
                                        _questions.length - 1) {
                                      setState(() {
                                        _currentQuestionIndex++;
                                      });
                                    } else {
                                      if (_isFormComplete()) {
                                        _submitResults();
                                      }
                                    }
                                  }
                                : null,
                        child: Text(
                          _currentQuestionIndex < _questions.length - 1
                              ? '下一题'
                              : '提交',
                          style: TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.white, // 保持文本为白色
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(int index) {
    String category = _categoriesWithQuestions.keys.firstWhere(
        (key) => _categoriesWithQuestions[key]!.contains(_questions[index]));
    final appStyle = AppStyle(context);

    return Card(
      color: appStyle.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 分类标签
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: appStyle.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                category, // 分类标题
                style: TextStyle(
                  fontSize: 14,
                  color: appStyle.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 16), // 分类标签和问题之间的间距
            // 问题文本
            Text(
              _questions[index],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: appStyle.textColor,
              ),
            ),
            SizedBox(height: 24), // 问题和选项之间的间距
            // 选项列表
            Column(
              children: List.generate(_options[index].length, (optionIndex) {
                bool isSelected = _selectedOptions[index] == optionIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOptions[index] = optionIndex;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? appStyle.primaryColor
                          : appStyle.cardBackgroundColor,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: isSelected
                            ? appStyle.primaryColor
                            : appStyle.cardBackgroundColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // 选中标记
                        Icon(
                          isSelected
                              ? CupertinoIcons.check_mark_circled_solid
                              : CupertinoIcons.circle,
                          color: isSelected
                              ? CupertinoColors.white
                              : appStyle.textColor,
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        // 选项文本
                        Expanded(
                          child: Text(
                            _options[index][optionIndex],
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? CupertinoColors.white
                                  : appStyle.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  bool _isFormComplete() {
    return _selectedOptions.length == _questions.length;
  }

  void _submitResults() {
    String mbtiResult = _calculateMBTI(); // 计算MBTI类型

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('测试完成'),
          content: Text('感谢您的参与！您的MBTI类型是：$mbtiResult。点击“查看结果”了解更多信息。'),
          actions: [
            CupertinoDialogAction(
              child: Text('查看结果'),
              onPressed: () {
                Navigator.of(context).pop(); // 关闭对话框
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => ResultsPage(mbtiType: mbtiResult),
                  ),
                );
              },
            ),
            CupertinoDialogAction(
              child: Text('好的'),
              onPressed: () {
                Navigator.of(context).pop();
                // 你可以在这里添加更多的导航逻辑，例如返回主页
              },
            ),
          ],
        );
      },
    );
  }
}
