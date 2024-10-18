import 'dart:convert';

import 'package:flutter/material.dart';

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
  Object _user = {};

  bool get login => _login;

  Object get user => _user;

  // 从缓存中加载登录状态
  Future<void> _loadLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _login = prefs.getBool('login') ?? false; // 如果缓存中没有值，默认false
    notifyListeners(); // 加载完成后通知监听者
  }

  Future<void> setUser(Object value) async {
    _user = value;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 将对象转换为 JSON 字符串存储
    String userJson = jsonEncode(_user);
    prefs.setString('user', userJson);
  }

  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 从 SharedPreferences 中读取 JSON 字符串
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      _user = jsonDecode(userJson); // 将 JSON 字符串转换为对象
    } else {
      getUserInfo(); // 如果没有存储的用户数据，设置为空对象
    }

    notifyListeners(); // 通知监听者数据已加载
  }

  // 设置登录状态并保存到缓存
  Future<void> setLogin(bool value) async {
    if (value) {
      getUserInfo();
    } else {
      setUser({});
    }
    _login = value;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', _login); // 将登录状态保存到缓存
  }

  // 通过API获取用户信息
  Future<void> getUserInfo() async {
    HttpHelper().getRequest('/user/info').then((value) {
      if (value['code'] == 0) {
        setUser(value['data']);
      } else {
        setLogin(false);
      }
    });
  }
}
