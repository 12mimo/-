import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';
import '../../styles/color.dart';

class WriteDiaryPage extends StatefulWidget {
  final DateTime date;
  final ValueChanged<String> onSave;

  const WriteDiaryPage({super.key, required this.date, required this.onSave});

  @override
  WriteDiaryPageState createState() => WriteDiaryPageState();
}

class WriteDiaryPageState extends State<WriteDiaryPage> {
  final _document = MutableDocument(nodes: [
    ParagraphNode(id: "1", text: AttributedText(''), metadata: {}),
  ]);
  late DocumentComposer _documentComposer;
  final _focusNode = FocusNode();
  String _selectedWeather = '晴天';
  String _selectedMood = '开心';

  @override
  void initState() {
    super.initState();
    _documentComposer = DocumentComposer(initialDocument: _document);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    String formattedDate =
    DateFormat('yyyy年MM月dd日 EEEE', 'zh_CN').format(widget.date);

    return Scaffold(
      backgroundColor: appStyle.backgroundColor,
      appBar: AppBar(
        backgroundColor: appStyle.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appStyle.primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('写日记 - $formattedDate',
            style: TextStyle(color: appStyle.primaryColor)),
        actions: [
          TextButton(
            onPressed: _saveDiary,
            child: Text('保存', style: TextStyle(color: appStyle.primaryColor)),
          ),
        ],
      ),
      body: _buildBody(appStyle),
    );
  }

  Widget _buildBody(AppStyle appStyle) {
    return Column(
      children: [
        _buildSelection(appStyle),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SuperEditor(
              editor: DocumentEditor(document: _document),
              composer: _documentComposer,
              focusNode: _focusNode,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelection(AppStyle appStyle) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('天气', style: TextStyle(fontSize: 16, color: appStyle.textColor)),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _weatherOption('晴天', Icons.wb_sunny),
              _weatherOption('多云', Icons.wb_cloudy),
              _weatherOption('雨天', Icons.beach_access),
              _weatherOption('雪天', Icons.ac_unit),
            ],
          ),
          SizedBox(height: 16),
          Text('心情', style: TextStyle(fontSize: 16, color: appStyle.textColor)),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _moodOption('开心', Icons.sentiment_satisfied),
              _moodOption('平静', Icons.sentiment_neutral),
              _moodOption('难过', Icons.sentiment_dissatisfied),
              _moodOption('生气', Icons.sentiment_very_dissatisfied),
            ],
          ),
        ],
      ),
    );
  }

  Widget _weatherOption(String label, IconData icon) {
    final appStyle = AppStyle(context);
    bool isSelected = _selectedWeather == label;
    return ChoiceChip(
      label: Text(label),
      avatar: Icon(
        icon,
        color: isSelected ? Colors.white : appStyle.primaryColor,
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedWeather = label;
        });
      },
      selectedColor: appStyle.primaryColor,
      backgroundColor: appStyle.backgroundColor,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : appStyle.textColor,
      ),
    );
  }

  Widget _moodOption(String label, IconData icon) {
    final appStyle = AppStyle(context);
    bool isSelected = _selectedMood == label;
    return ChoiceChip(
      label: Text(label),
      avatar: Icon(
        icon,
        color: isSelected ? Colors.white : appStyle.primaryColor,
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedMood = label;
        });
      },
      selectedColor: appStyle.primaryColor,
      backgroundColor: appStyle.backgroundColor,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : appStyle.textColor,
      ),
    );
  }

  void _saveDiary() {
    final content = _document.toPlainText();

    if (content.trim().isEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('提示'),
          content: Text('日记内容不能为空。'),
          actions: [
            CupertinoDialogAction(
              child: Text('确定'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }

    String diaryContent =
        '天气: $_selectedWeather\n心情: $_selectedMood\n内容: $content';

    widget.onSave(diaryContent);
    Navigator.pop(context);
  }
}
