import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final primaryColor = isDarkMode ? Color(0xFF80CBC4) : Color(0xFF00838F);
    final backgroundColor = isDarkMode ? const Color(0xFF37474F) : const Color(0xFFF5F5F5);
    final textColor = isDarkMode ? Color(0xFFCFD8DC) : Color(0xFF546E7A);

    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '登录',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: backgroundColor,
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
                style: TextStyle(color: textColor),
                decoration: BoxDecoration(
                  color: isDarkMode ? Color(0xFF455A64) : Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                placeholder: '密码',
                padding: const EdgeInsets.all(16.0),
                obscureText: true,
                style: TextStyle(color: textColor),
                decoration: BoxDecoration(
                  color: isDarkMode ? Color(0xFF455A64) : Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              const SizedBox(height: 40),
              CupertinoButton(
                color: primaryColor,
                borderRadius: BorderRadius.circular(15.0),
                onPressed: () {
                  // 登录按钮点击事件处理
                },
                child: Text(
                  '登录',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
