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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // 返回按钮点击事件处理
          },
          child: Icon(
            CupertinoIcons.back,
            color: primaryColor, // 设置返回按钮的颜色
          ),
        ),
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
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // 忘记密码点击事件
                  },
                  child: Text(
                    '忘记密码？',
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
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
              const SizedBox(height: 20),
              CupertinoButton(
                child: Text(
                  '注册',
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                  ),
                ),
                onPressed: () {
                  // 跳转到注册页面
                },
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          // Google 登录逻辑
                        },
                        child: Icon(
                          Icons.login, // 临时使用一个系统图标替代
                          size: 40,
                          color: primaryColor,
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          // Apple 登录逻辑
                        },
                        child: Icon(
                          Icons.apple, // 临时使用一个系统图标替代
                          size: 40,
                          color: primaryColor,
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          // Facebook 登录逻辑
                        },
                        child: Icon(
                          Icons.facebook, // 临时使用一个系统图标替代
                          size: 40,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '注册即表示同意',
                    style: TextStyle(
                      fontSize: 12,
                      color: textColor,
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
                        color: primaryColor,
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
