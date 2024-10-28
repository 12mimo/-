
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlfz/styles/color.dart';

import '../../utils/sys.dart';

class ArticleDetailPage extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String content;
  final String id;

  const ArticleDetailPage({
    super.key,
    required this.title,
    required this.author,
    required this.date,
    required this.content,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
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
          '文章详情',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: appStyle.backgroundColor,
        border: Border.all(color: Colors.transparent),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: appStyle.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '作者: $author',
                    style: TextStyle(
                      color: appStyle.textColor.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '发布日期: $date',
                    style: TextStyle(
                      color: appStyle.textColor.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Divider(
                color: appStyle.accentColor.withOpacity(0.5),
                thickness: 1,
              ),
              const SizedBox(height: 20),
              Text(
                content,
                style: TextStyle(
                  fontSize: 18,
                  color: appStyle.textColor,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),
              Divider(
                color: appStyle.accentColor.withOpacity(0.5),
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
