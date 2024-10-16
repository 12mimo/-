import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool isPhoneSelected = true;

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final primaryColor = isDarkMode ? Color(0xFF80CBC4) : Color(0xFF00838F);
    final backgroundColor = isDarkMode ? const Color(0xFF37474F) : const Color(0xFFB2EBF2);
    final textColor = isDarkMode ? Color(0xFFCFD8DC) : Color(0xFF546E7A);

    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Return to the previous page
          },
          child: Icon(
            CupertinoIcons.back,
            color: primaryColor,
          ),
        ),
        middle: Text(
          '忘记密码',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoSegmentedControl<bool>(
                    children: {
                      true: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text('手机号找回', style: TextStyle(color: isPhoneSelected ? Colors.white : primaryColor)),
                      ),
                      false: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text('邮箱找回', style: TextStyle(color: !isPhoneSelected ? Colors.white : primaryColor)),
                      ),
                    },
                    groupValue: isPhoneSelected,
                    onValueChanged: (bool value) {
                      setState(() {
                        isPhoneSelected = value;
                      });
                    },
                    selectedColor: primaryColor,
                    borderColor: primaryColor,
                    unselectedColor: backgroundColor,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                placeholder: isPhoneSelected ? '请输入您的手机号' : '请输入您的邮箱',
                padding: const EdgeInsets.all(16.0),
                style: TextStyle(color: textColor),
                keyboardType: isPhoneSelected ? TextInputType.phone : TextInputType.emailAddress,
                decoration: BoxDecoration(
                  color: isDarkMode ? Color(0xFF455A64) : Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: primaryColor,
                borderRadius: BorderRadius.circular(15.0),
                onPressed: () {
                  // Navigate to the next step after sending verification code or reset link
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => VerificationPage(isPhoneSelected: isPhoneSelected),
                  ));
                },
                child: Text(
                  isPhoneSelected ? '发送验证码' : '发送重置链接',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    '返回登录',
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                    ),
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

class VerificationPage extends StatelessWidget {
  final bool isPhoneSelected;

  const VerificationPage({required this.isPhoneSelected, super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final primaryColor = isDarkMode ? Color(0xFF80CBC4) : Color(0xFF00838F);
    final backgroundColor = isDarkMode ? const Color(0xFF37474F) : const Color(0xFFB2EBF2);
    final textColor = isDarkMode ? Color(0xFFCFD8DC) : Color(0xFF546E7A);

    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Return to the previous page
          },
          child: Icon(
            CupertinoIcons.back,
            color: primaryColor,
          ),
        ),
        middle: Text(
          isPhoneSelected ? '输入验证码' : '验证邮箱',
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
                placeholder: isPhoneSelected ? '请输入收到的验证码' : '请输入您的邮箱中的验证码',
                padding: const EdgeInsets.all(16.0),
                style: TextStyle(color: textColor),
                keyboardType: TextInputType.number,
                decoration: BoxDecoration(
                  color: isDarkMode ? Color(0xFF455A64) : Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: primaryColor,
                borderRadius: BorderRadius.circular(15.0),
                onPressed: () {
                  // Handle verification logic here
                },
                child: Text(
                  '验证',
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