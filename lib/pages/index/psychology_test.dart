import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlfz/styles/color.dart';

class PsychologyTestPage extends StatefulWidget {
  final String title;
  final String description;
  final List<String> questions;
  final List<List<String>> options;
  final List<List<Map<String, int>>> optionScores;
  final Function(Map<String, int>) resultCalculator;
  final Widget Function(String result) resultPageBuilder;

  const PsychologyTestPage({
    super.key,
    required this.title,
    required this.description,
    required this.questions,
    required this.options,
    required this.optionScores,
    required this.resultCalculator,
    required this.resultPageBuilder,
  });

  @override
  GenericTestPageState createState() => GenericTestPageState();
}

class GenericTestPageState extends State<PsychologyTestPage> {
  final Map<int, int> _selectedOptions = {};
  int _currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: appStyle.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          widget.title,
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
            _buildProgressIndicator(),
            Expanded(child: _buildQuestionSection()),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / widget.questions.length,
            backgroundColor: CupertinoColors.systemGrey4,
            valueColor: AlwaysStoppedAnimation<Color>(AppStyle(context).primaryColor),
          ),
          SizedBox(height: 8),
          Text(
            '第 ${_currentQuestionIndex + 1} / ${widget.questions.length} 题',
            style: TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionSection() {
    final appStyle = AppStyle(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.description,
            style: TextStyle(fontSize: 18, color: appStyle.primaryColor),
          ),
          SizedBox(height: 24),
          _buildQuestionCard(),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
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
            Text(
              widget.questions[_currentQuestionIndex],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: appStyle.textColor),
            ),
            SizedBox(height: 24),
            Column(
              children: List.generate(widget.options[_currentQuestionIndex].length, (optionIndex) {
                bool isSelected = _selectedOptions[_currentQuestionIndex] == optionIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOptions[_currentQuestionIndex] = optionIndex;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: isSelected ? appStyle.primaryColor : appStyle.cardBackgroundColor,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: isSelected ? appStyle.primaryColor : appStyle.cardBackgroundColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.circle,
                          color: isSelected ? CupertinoColors.white : appStyle.textColor,
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.options[_currentQuestionIndex][optionIndex],
                            style: TextStyle(fontSize: 16, color: isSelected ? CupertinoColors.white : appStyle.textColor),
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

  Widget _buildBottomButtons() {
    final appStyle = AppStyle(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        children: [
          if (_currentQuestionIndex > 0)
            Expanded(
              child: CupertinoButton(
                color: CupertinoColors.systemGrey,
                borderRadius: BorderRadius.circular(8.0),
                onPressed: () => setState(() => _currentQuestionIndex--),
                child: Text('上一题', style: TextStyle(fontSize: 16, color: CupertinoColors.white)),
              ),
            ),
          if (_currentQuestionIndex > 0) SizedBox(width: 16),
          Expanded(
            child: CupertinoButton(
              color: _selectedOptions.containsKey(_currentQuestionIndex) ? appStyle.primaryColor : CupertinoColors.systemGrey,
              borderRadius: BorderRadius.circular(8.0),
              onPressed: _selectedOptions.containsKey(_currentQuestionIndex) ? _onNextPressed : null,
              child: Text(
                _currentQuestionIndex < widget.questions.length - 1 ? '下一题' : '提交',
                style: TextStyle(fontSize: 16, color: CupertinoColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onNextPressed() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() => _currentQuestionIndex++);
    } else if (_isFormComplete()) {
      _showResultDialog();
    }
  }

  bool _isFormComplete() {
    return _selectedOptions.length == widget.questions.length;
  }

  void _showResultDialog() {
    final resultScores = _calculateScores();
    final result = widget.resultCalculator(resultScores);

    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('测试完成'),
        content: Text('感谢您的参与！您的测试结果是：$result。点击“查看结果”了解更多信息。'),
        actions: [
          CupertinoDialogAction(
            child: Text('查看结果'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => widget.resultPageBuilder(result)),
              );
            },
          ),
          CupertinoDialogAction(
            child: Text('好的'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Map<String, int> _calculateScores() {
    Map<String, int> scores = {};
    _selectedOptions.forEach((questionIndex, optionIndex) {
      widget.optionScores[questionIndex][optionIndex].forEach((key, value) {
        scores[key] = (scores[key] ?? 0) + value;
      });
    });
    return scores;
  }
}