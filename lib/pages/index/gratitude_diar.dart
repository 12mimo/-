import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../styles/color.dart';
import '../../utils/sys.dart';

class GratitudeJournalPage extends StatefulWidget {
  @override
  _GratitudeJournalPageState createState() => _GratitudeJournalPageState();
}

class _GratitudeJournalPageState extends State<GratitudeJournalPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<String, String> _diaryEntries = {}; // 存储日记，Key为日期的字符串格式

  @override
  void initState() {
    super.initState();
    // 初始化日期格式化，设置为中文
    initializeDateFormatting('zh_CN');
  }

  @override
  Widget build(BuildContext context) {
    int totalEntries = _diaryEntries.length;
    int consecutiveDays = _calculateConsecutiveDays();
    final appStyle = AppStyle(context);
    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => goBack(context),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text('感恩日记', style: TextStyle(
          color: appStyle.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.search,color: appStyle.primaryColor,),
          onPressed: () {
            // 跳转到搜索页面
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    SearchDiaryPage(diaryEntries: _diaryEntries),
              ),
            );
          },
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              appStyle.backgroundColor,
              appStyle.primaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(totalEntries, consecutiveDays),
              SizedBox(height: 20),
              Expanded(
                child: _buildCalendar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(int totalEntries, int consecutiveDays) {
    final appStyle = AppStyle(context);
    return Column(
      children: [
        Text(
          '欢迎回来！',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '总日记数：$totalEntries  连续天数：$consecutiveDays',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        Text(
          _getDailyQuote(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: appStyle.primaryColor,
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    final appStyle = AppStyle(context);
    return Material(
      color: Colors.transparent,
      child: TableCalendar(
        locale: 'zh_CN',
        // 设置语言为中文
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        enabledDayPredicate: (day) {
          // 禁用未来的日期
          return !day.isAfter(DateTime.now());
        },
        calendarFormat: CalendarFormat.month,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Icon(
            CupertinoIcons.chevron_left,
            color: appStyle.primaryColor,
          ),
          rightChevronIcon: Icon(
            CupertinoIcons.chevron_right,
            color: appStyle.primaryColor,
          ),
          titleTextStyle: TextStyle(
            color: appStyle.primaryColor,
            fontSize: 18,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: appStyle.primaryColor),
          weekendStyle: TextStyle(color: appStyle.primaryColor),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          defaultTextStyle: TextStyle(color: appStyle.primaryColor),
          weekendTextStyle: TextStyle(color: appStyle.primaryColor),
          todayDecoration: BoxDecoration(
            color: appStyle.primaryColor,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: CupertinoColors.activeBlue,
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: CupertinoColors.systemGrey,
            shape: BoxShape.circle,
          ),
          disabledTextStyle: TextStyle(
            color: CupertinoColors.inactiveGray, // 禁用日期的文本样式
          ),
        ),
        onDaySelected: (selectedDay, focusedDay) {
          if (selectedDay.isAfter(DateTime.now())) {
            // 禁止选择未来的日期
            return;
          }

          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          String dateKey = _formatDate(selectedDay);
          bool hasDiary = _diaryEntries.containsKey(dateKey);

          if (hasDiary) {
            // 跳转到查看日记页面
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ViewDiaryPage(
                  date: selectedDay,
                  content: _diaryEntries[dateKey]!,
                  onDelete: () {
                    setState(() {
                      _diaryEntries.remove(dateKey);
                    });
                  },
                ),
              ),
            );
          } else {
            // 跳转到编写日记页面
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => WriteDiaryPage(
                  date: selectedDay,
                  onSave: (String content) {
                    setState(() {
                      _diaryEntries[dateKey] = content;
                    });
                  },
                ),
              ),
            );
          }
        },
        eventLoader: (day) {
          String dateKey = _formatDate(day);
          if (_diaryEntries.containsKey(dateKey)) {
            return [dateKey]; // 返回非空列表表示有事件
          }
          return [];
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  int _calculateConsecutiveDays() {
    // 计算连续写日记的天数
    List<String> dates = _diaryEntries.keys.toList();
    dates.sort((a, b) => b.compareTo(a)); // 按日期从近到远排序

    int count = 0;
    DateTime? lastDate;

    for (String dateStr in dates) {
      DateTime date = DateTime.parse(dateStr);
      if (lastDate == null) {
        lastDate = date;
        count++;
      } else {
        if (lastDate.subtract(Duration(days: 1)).isAtSameMomentAs(date)) {
          count++;
          lastDate = date;
        } else {
          break;
        }
      }
    }
    return count;
  }

  String _getDailyQuote() {
    // 返回每日名言，可以根据需要改为从接口获取
    List<String> quotes = [
      "每天都是新的开始。",
      "心怀感恩，幸福常在。",
      "珍惜当下，活在当下。",
      "努力让自己变得更好。",
      "微笑面对生活的挑战。",
    ];
    return quotes[DateTime.now().day % quotes.length];
  }
}

// 编写日记页面
class WriteDiaryPage extends StatefulWidget {
  final DateTime date;
  final ValueChanged<String> onSave;

  WriteDiaryPage({required this.date, required this.onSave});

  @override
  _WriteDiaryPageState createState() => _WriteDiaryPageState();
}

class _WriteDiaryPageState extends State<WriteDiaryPage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('yyyy年MM月dd日 EEEE', 'zh_CN').format(widget.date);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('写日记 - $formattedDate'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('保存'),
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onSave(_controller.text);
              Navigator.pop(context);
            } else {
              // 提示用户输入内容
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
            }
          },
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: CupertinoTextField(
          controller: _controller,
          placeholder: '写下今天的感恩日记...',
          maxLines: null,
          autofocus: true,
        ),
      ),
    );
  }
}

// 查看日记页面
class ViewDiaryPage extends StatelessWidget {
  final DateTime date;
  final String content;
  final VoidCallback onDelete;

  ViewDiaryPage(
      {required this.date, required this.content, required this.onDelete});

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
              child: Icon(CupertinoIcons.delete),
              onPressed: () {
                // 确认删除
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text('删除日记'),
                    content: Text('确定要删除这篇日记吗？'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('取消'),
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

  SearchDiaryPage({required this.diaryEntries});

  @override
  _SearchDiaryPageState createState() => _SearchDiaryPageState();
}

class _SearchDiaryPageState extends State<SearchDiaryPage> {
  TextEditingController _searchController = TextEditingController();
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
