import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

import '../main.dart';

void goBack(BuildContext context, [Widget? page, bool shouldRefresh = false]) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop(shouldRefresh); // 如果可以返回上一页，传递 shouldRefresh 值
  } else {
    // 如果没有上一页，跳转到目标页面，使用 pushReplacement 确保新的页面被替换
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
          builder: (context) => page ?? CupertinoStoreHomePage()),
    );
  }
}

class NetworkUtil {
  final Connectivity _connectivity = Connectivity();

  // 检查网络连接的方法
  Future<String> checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return 'Mobile Network';
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return 'WiFi';
    } else {
      return 'No Network';
    }
  }
}
