import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/http.dart';

class GlobalState with ChangeNotifier {
  static final GlobalState _instance = GlobalState._internal();

  factory GlobalState() {
    return _instance;
  }

  GlobalState._internal() {
    _loadLoginStatus(); // 构造函数中调用加载方法
    _loadUser();
  }

  bool _login = false;
  Map<String, dynamic> _user = {}; // 确保 _user 不会是 null

  bool get login => _login;

  Map<String, dynamic> get user {
    if (_user.isEmpty && _login) {
      getUserInfo();
    }
    return _user;
  }

  // 从缓存中加载登录状态
  Future<void> _loadLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _login = prefs.getBool('login') ?? false; // 如果缓存中没有值，默认false
    notifyListeners(); // 加载完成后通知监听者
  }

  // 保存用户信息并存储到缓存
  Future<void> setUser(Map<String, dynamic> value) async {
    _user = value;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(_user);
    prefs.setString('user', userJson);
  }

  // 从缓存中加载用户信息
  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = prefs.getString('user');

    if (userJson != null) {
      _user = jsonDecode(userJson);
    } else {
      _user = {}; // 确保 _user 初始化为一个空 Map 而不是 null
    }

    notifyListeners(); // 通知监听者数据已加载
  }

  // 设置登录状态并保存到缓存
  Future<void> setLogin(bool value) async {
    _login = value;

    if (!value) {
      setUser({}); // 清空用户信息
    } else {
      await getUserInfo(); // 获取用户信息
    }

    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', _login);
  }

  // 通过API获取用户信息
  Future<void> getUserInfo() async {
    HttpHelper().getRequest('/user/info', requireAuth: true).then((value) {
      if (value['code'] == 0) {
        setUser(value['data']);
      } else {
        setLogin(false);
      }
    });
  }
}
