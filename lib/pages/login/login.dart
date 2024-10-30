import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlfz/pages/login/register.dart';
import 'package:xlfz/store/global.dart';

import '../../styles/color.dart';
import '../../utils/cache.dart';
import '../../utils/http.dart';
import '../../utils/sys.dart';
import '../../utils/toast.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);


  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final HttpHelper _httpHelper = HttpHelper();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    String phone = _phoneController.text;
    String password = _passwordController.text;

    if (phone.isEmpty) {
      showSimpleToast(context, "手机号不能为空");
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
        'phone': phone,
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
    final appStyle = AppStyle(context);

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => goBack(context),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          '登录',
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
              _buildTextField(_phoneController, '手机号', false,
                  appStyle.textColor, appStyle.cardBackgroundColor),
              const SizedBox(height: 20),
              _buildTextField(_passwordController, '密码', true,
                  appStyle.textColor, appStyle.cardBackgroundColor),
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
                      color: appStyle.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _buildButton(
                  '登录', appStyle.primaryColor, appStyle.textColor, _login),
              const SizedBox(height: 20),
              _buildButton('注册', appStyle.primaryColor, appStyle.textColor, () {
                Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(builder: (context) => RegisterPage()));
              }),
              const SizedBox(height: 20),
              _buildSocialLoginButtons(appStyle.primaryColor),
              const SizedBox(height: 20),
              _buildPrivacyAgreement(appStyle.textColor, appStyle.primaryColor),
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
