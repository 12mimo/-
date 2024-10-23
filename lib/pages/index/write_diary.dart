import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
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
  final MutableDocument _document = MutableDocument(nodes: [
    ParagraphNode(id: DocumentEditor.createNodeId(), text: AttributedText('')),
  ]);

  late DocumentEditor _editor;
  late DocumentComposer _composer;
  final _focusNode = FocusNode();
  String _selectedWeather = '晴天';
  String _selectedMood = '开心';

  @override
  void initState() {
    super.initState();
    _editor = DocumentEditor(document: _document);
    _composer = DocumentComposer();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _composer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    String formattedDate =
        DateFormat('yyyy年MM月dd日 EEEE', 'zh_CN').format(widget.date);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: appStyle.backgroundColor,
        middle: Text(
          '写日记 - $formattedDate',
          style: TextStyle(color: appStyle.primaryColor),
        ),
        leading: CupertinoNavigationBarBackButton(
          color: appStyle.primaryColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _saveDiary,
          child: Text(
            '保存',
            style: TextStyle(color: appStyle.primaryColor),
          ),
        ),
      ),
      child: _buildBody(appStyle),
    );
  }

  Widget _buildBody(AppStyle appStyle) {
    return Column(
      children: [
        _buildSelection(appStyle),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: SuperEditor(
                editor: _editor,
                composer: _composer,
                focusNode: _focusNode,
                inputSource: TextInputSource.ime,
                gestureMode: DocumentGestureMode.iOS,
                stylesheet: defaultStylesheet.copyWith(
                  documentPadding: EdgeInsets.zero,
                ),
              ),
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
          CupertinoSegmentedControl<String>(
            children: {
              '晴天': Text('晴天'),
              '多云': Text('多云'),
              '雨天': Text('雨天'),
              '雪天': Text('雪天'),
            },
            groupValue: _selectedWeather,
            onValueChanged: (value) {
              setState(() {
                _selectedWeather = value!;
              });
            },
          ),
          SizedBox(height: 16),
          Text('心情', style: TextStyle(fontSize: 16, color: appStyle.textColor)),
          SizedBox(height: 8),
          CupertinoSegmentedControl<String>(
            children: {
              '开心': Text('开心'),
              '平静': Text('平静'),
              '难过': Text('难过'),
              '生气': Text('生气'),
            },
            groupValue: _selectedMood,
            onValueChanged: (value) {
              setState(() {
                _selectedMood = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  void _saveDiary() {
    final content = _getPlainTextFromDocument(_document);

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

  String _getPlainTextFromDocument(MutableDocument document) {
    final buffer = StringBuffer();
    for (final node in document.nodes) {
      if (node is ParagraphNode) {
        buffer.writeln(node.text.text);
      }
    }
    return buffer.toString();
  }
}
