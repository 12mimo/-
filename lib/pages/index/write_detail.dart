import 'package:flutter/cupertino.dart';
import 'dart:io';

import '../../styles/color.dart';
import '../../utils/sys.dart';

class DiaryPage extends StatefulWidget {
  final String date;
  final Function(String) onSave;
  const DiaryPage({super.key, required this.date, required this.onSave});

  @override
  DiaryPageState createState() => DiaryPageState();
}

class DiaryPageState extends State<DiaryPage> {
  final TextEditingController _textController = TextEditingController();
  final DateTime _selectedDate = DateTime.now();
  File? _image;

  Future<void> _pickImage() async {
    // 使用图片选择插件获取图片
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => goBack(context),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          '写日记',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: appStyle.primaryColor),
        ),
        backgroundColor: appStyle.backgroundColor,
        border: null,
      ),
      backgroundColor: appStyle.backgroundColor,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: appStyle.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(CupertinoIcons.person_fill, size: 24, color: appStyle.primaryColor),
                        SizedBox(width: 8),
                        Text(
                          '用户今日状态',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: appStyle.textColor),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemYellow.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '晴 23°C  ${_selectedDate.toIso8601String().substring(0, 10)}',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: appStyle.textColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: CupertinoColors.systemGrey4),
                ),
                child: CupertinoTextField(
                  controller: _textController,
                  maxLines: 10,
                  placeholder: '记录你的心情与经历...',
                  padding: EdgeInsets.all(20),
                  decoration: null,
                  style: TextStyle(fontSize: 18, color: appStyle.textColor, height: 1.5),
                  placeholderStyle: TextStyle(color: CupertinoColors.systemGrey, fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 24),
            CupertinoButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.cloud_upload, color: CupertinoColors.white),
                  SizedBox(width: 8),
                  Text('上传图片', style: TextStyle(fontSize: 18, color: CupertinoColors.white)),
                ],
              ),
              color: appStyle.primaryColor,
              onPressed: _pickImage,
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 28),
              borderRadius: BorderRadius.circular(30),
            ),
            SizedBox(height: 16),
            if (_image != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      _image!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
