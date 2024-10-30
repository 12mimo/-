// 查看日记页面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewDiaryPage extends StatelessWidget {
  final DateTime date;
  final String content;
  final VoidCallback onDelete;

  const ViewDiaryPage({Key key, this.date, this.content, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy年MM月dd日 EEEE', 'zh_CN').format(date);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('日记详情 - $formattedDate'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.delete),
              onPressed: () {
                // 确认删除
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text('删除日记'),
                    content: const Text('确定要删除这篇日记吗？'),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('取消'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      CupertinoDialogAction(
                        child: Text('删除'),
                        isDestructiveAction: true,
                        onPressed: () {
                          onDelete();
                          Navigator.pop(context); // 关闭对话框
                          Navigator.pop(context); // 返回上一页
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          content,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// 搜索日记页面
class SearchDiaryPage extends StatefulWidget {
  final Map<String, String> diaryEntries;

  const SearchDiaryPage({Key key,   this.diaryEntries}) : super(key: key);

  @override
  SearchDiaryPageState createState() => SearchDiaryPageState();
}

class SearchDiaryPageState extends State<SearchDiaryPage> {
  final TextEditingController _searchController = TextEditingController();
  List<MapEntry<String, String>> _searchResults = [];

  void _searchDiaries(String query) {
    setState(() {
      _searchResults = widget.diaryEntries.entries
          .where((entry) => entry.value.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('搜索日记'),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: CupertinoSearchTextField(
              controller: _searchController,
              placeholder: '输入关键字搜索',
              onChanged: _searchDiaries,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                var entry = _searchResults[index];
                DateTime date = DateTime.parse(entry.key);
                String formattedDate =
                    DateFormat('yyyy年MM月dd日', 'zh_CN').format(date);
                return ListTile(
                  title: Text(formattedDate),
                  subtitle: Text(
                    entry.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ViewDiaryPage(
                          date: date,
                          content: entry.value,
                          onDelete: () {
                            setState(() {
                              widget.diaryEntries.remove(entry.key);
                              _searchResults.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
