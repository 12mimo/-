import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlfz/pages/login/register.dart';

import '../../styles/index.dart';
import '../../utils/cache.dart';
import '../../utils/http.dart';
import '../../utils/sys.dart';
import '../../utils/toast.dart';
import '../personal/profile.dart';
import 'forgot_password.dart';

class LoginPage  extends StatelessWidget  {
   LoginPage({super.key});
   final TextEditingController usernameController = TextEditingController();
   final TextEditingController passwordController = TextEditingController();
   final httpHelper = HttpHelper();

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final primaryColor = isDarkMode ? AppColors.darkPrimaryColor : AppColors.lightPrimaryColor;
    final backgroundColor =
    isDarkMode ? AppColors.darkBackgroundColor : AppColors.lightBackgroundColor;
    final textColor = isDarkMode ? AppColors.darkTextColor : AppColors.lightTextColor;
    final cardBackgroundColor = isDarkMode ? AppColors.darkCardBackgroundColor : AppColors.lightCardBackgroundColor;
    // 登录
    void login () async {
      String username = usernameController.text;
      String password = passwordController.text;

      if (username == ""){
        showSimpleToast(context,"用户名不能为空");
        return;
      }
      if (password == ""){
        showSimpleToast(context,"密码不能为空");
        return;
      }

      // 发送登录请求
      var postResponse = await httpHelper.postRequest("/login", {
        'username': username,
        'password': password,
      }, requireAuth: false);
      if (postResponse['code'] == 0) {
        // 登录成功
        saveToCache("token",postResponse['data']["token"]);
        goBack(context);
      }else{
        String errorMessage = postResponse['message'] ?? '登录失败';
        showSimpleToast(context,errorMessage);
      }

    }
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            goBack(context,);
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
                controller: usernameController,
                placeholder: '用户名',
                padding: const EdgeInsets.all(16.0),
                style: TextStyle(color: textColor),
                decoration: BoxDecoration(
                  color: cardBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                controller: passwordController,
                placeholder: '密码',
                padding: const EdgeInsets.all(16.0),
                obscureText: true,
                style: TextStyle(color: textColor),
                decoration: BoxDecoration(
                  color: cardBackgroundColor,
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
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => ForgotPasswordPage()));
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
                  login();
                },
                child: Text(
                  '登录',
                  style: TextStyle(
                    fontSize: 18,
                    color: textColor,
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
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => RegisterPage()));
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
                          Icons.mobile_friendly, // 临时使用一个系统图标替代
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
                          Icons.wechat, // 临时使用一个系统图标替代
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
