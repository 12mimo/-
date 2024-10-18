import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlfz/pages/login/register.dart';
import 'package:xlfz/store/global.dart';

import '../../styles/index.dart';
import '../../utils/cache.dart';
import '../../utils/http.dart';
import '../../utils/sys.dart';
import '../../utils/toast.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final HttpHelper _httpHelper = HttpHelper();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty) {
      showSimpleToast(context, "用户名不能为空");
      return;
    }
    if (password.isEmpty) {
      showSimpleToast(context, "密码不能为空");
      return;
    }

    // 发送登录请求
    var postResponse = await _httpHelper.postRequest(
      "/login",
      {
        'username': username,
        'password': password,
      },
      requireAuth: false,
    );

    if (postResponse['code'] == 0) {
      // 登录成功
      context.read<GlobalState>().setLogin(true);
      saveToCache("token", postResponse['data']["token"]);
      goBack(context);
    } else {
      String errorMessage = postResponse['message'] ?? '登录失败';
      showSimpleToast(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final primaryColor =
        isDarkMode ? AppColors.darkPrimaryColor : AppColors.lightPrimaryColor;
    final backgroundColor = isDarkMode
        ? AppColors.darkBackgroundColor
        : AppColors.lightBackgroundColor;
    final textColor =
        isDarkMode ? AppColors.darkTextColor : AppColors.lightTextColor;
    final cardBackgroundColor = isDarkMode
        ? AppColors.darkCardBackgroundColor
        : AppColors.lightCardBackgroundColor;

    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => goBack(context),
          child: Icon(
            CupertinoIcons.back,
            color: primaryColor,
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
              _buildTextField(_usernameController, '用户名', false, textColor,
                  cardBackgroundColor),
              const SizedBox(height: 20),
              _buildTextField(_passwordController, '密码', true, textColor,
                  cardBackgroundColor),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(
                          builder: (context) => ForgotPasswordPage())),
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
              _buildButton('登录', primaryColor, textColor, _login),
              const SizedBox(height: 20),
              _buildButton('注册', primaryColor, textColor, () {
                Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(builder: (context) => RegisterPage()));
              }),
              const SizedBox(height: 20),
              _buildSocialLoginButtons(primaryColor),
              const SizedBox(height: 20),
              _buildPrivacyAgreement(textColor, primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String placeholder,
      bool obscureText, Color textColor, Color backgroundColor) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      padding: const EdgeInsets.all(16.0),
      obscureText: obscureText,
      style: TextStyle(color: textColor),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  Widget _buildButton(
      String text, Color color, Color textColor, VoidCallback onPressed) {
    return CupertinoButton(
      color: color,
      borderRadius: BorderRadius.circular(15.0),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildSocialLoginButtons(Color iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialButton(Icons.mobile_friendly, iconColor, () {
          // Google 登录逻辑
        }),
        _buildSocialButton(Icons.apple, iconColor, () {
          // Apple 登录逻辑
        }),
        _buildSocialButton(Icons.wechat, iconColor, () {
          // Facebook 登录逻辑
        }),
      ],
    );
  }

  Widget _buildSocialButton(
      IconData icon, Color color, VoidCallback onPressed) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Icon(
        icon,
        size: 40,
        color: color,
      ),
    );
  }

  Widget _buildPrivacyAgreement(Color textColor, Color primaryColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
    );
  }
}
