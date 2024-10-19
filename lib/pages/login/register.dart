import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/color.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // 返回按钮点击事件处理
          },
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor, // 设置返回按钮的颜色
          ),
        ),
        middle: Text(
          '注册',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: appStyle.backgroundColor,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CupertinoTextField(
                placeholder: '用户名',
                padding: const EdgeInsets.all(16.0),
                style: TextStyle(color: appStyle.textColor),
                decoration: BoxDecoration(
                  color: appStyle.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                placeholder: '邮箱',
                padding: const EdgeInsets.all(16.0),
                style: TextStyle(color: appStyle.textColor),
                decoration: BoxDecoration(
                  color: appStyle.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                placeholder: '密码',
                padding: const EdgeInsets.all(16.0),
                obscureText: true,
                style: TextStyle(color: appStyle.textColor),
                decoration: BoxDecoration(
                  color: appStyle.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              const SizedBox(height: 40),
              CupertinoButton(
                color: appStyle.primaryColor,
                borderRadius: BorderRadius.circular(15.0),
                onPressed: () {
                  // 注册按钮点击事件处理
                },
                child: Text(
                  '注册',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                child: Text(
                  '已有账号？登录',
                  style: TextStyle(
                    fontSize: 16,
                    color: appStyle.primaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(builder: (context) => LoginPage()));
                },
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '注册即表示同意',
                    style: TextStyle(
                      fontSize: 12,
                      color: appStyle.textColor,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // 隐私协议点击事件
                    },
                    child: Text(
                      '隐私协议',
                      style: TextStyle(
                        fontSize: 12,
                        color: appStyle.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
