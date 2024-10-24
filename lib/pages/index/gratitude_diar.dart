import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:xlfz/pages/index/see_diar.dart';
import 'package:xlfz/pages/index/write_diary.dart';

import '../../styles/color.dart';
import '../../utils/sys.dart';

class GratitudeJournalPage extends StatefulWidget {
  const GratitudeJournalPage({super.key});

  @override
  _GratitudeJournalPageState createState() => _GratitudeJournalPageState();
}

class _GratitudeJournalPageState extends State<GratitudeJournalPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<String, String> _diaryEntries = {}; // 存储日记，Key为日期的字符串格式

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
        middle: Text(
          '感恩日记',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.search,
            color: appStyle.primaryColor,
          ),
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
              appStyle.backgroundColor,
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
        firstDay: DateTime.utc(1970, 1, 1),
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
            color: appStyle.textColor,
          ),
          rightChevronIcon: Icon(
            CupertinoIcons.chevron_right,
            color: appStyle.textColor,
          ),
          titleTextStyle: TextStyle(
            color: appStyle.textColor,
            fontSize: 18,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: appStyle.textColor),
          weekendStyle: TextStyle(color: appStyle.textColor),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          defaultTextStyle: TextStyle(color: appStyle.textColor),
          weekendTextStyle: TextStyle(color: appStyle.textColor),
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
                builder: (context) => EmotionPage(
                  date: selectedDay.toString(),
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
