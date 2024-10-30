import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';

void goBack(BuildContext context, [Widget page, bool shouldRefresh = false]) {
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

class NotificationUtil {
  Future<bool> checkNotification() async {
    var status = await Permission.notification.status;
    if (status.isDenied || status.isRestricted) {
      // 请求权限
      status = await Permission.notification.request();
    }
    if (status.isGranted) {
      print("Microphone permission granted.");
    } else {
      print("Microphone permission denied.");
    }
    return true;
  }
}

class RequestMultiplePermissions {
  Future<bool> requestMultiplePermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.photos,
      Permission.storage,
      Permission.notification,
      Permission.activityRecognition,
      Permission.criticalAlerts,
      // Permission.assistant,
      // Permission.backgroundRefresh,
    ].request();
    return statuses.values
        .every((status) => status == PermissionStatus.granted);
  }
}

String formatDateTime(dynamic dateTime) {
  // 如果输入是字符串类型，将其转换为DateTime类型
  if (dateTime is String) {
    dateTime = DateTime.parse(dateTime).toLocal();
  }
  // 定义日期格式，例如：2024年10月23日 14:30
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(dateTime);
}
