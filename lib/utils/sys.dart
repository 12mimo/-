import 'package:flutter/cupertino.dart';

import '../main.dart';

void goBack(BuildContext context, [Widget? page]) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context); // 返回上一页
  } else {
    // 如果 page 为 null，设置为首页
    var destinationPage = page ?? CupertinoStoreHomePage();

    // 如果没有上一页，跳转到目标页面
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => destinationPage),
    );
  }
}
