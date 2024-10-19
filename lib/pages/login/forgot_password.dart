import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/color.dart';
import 'login.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool isPhoneSelected = true;

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Return to the previous page
          },
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          '忘记密码',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoSegmentedControl<bool>(
                    children: {
                      true: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text('手机号找回',
                            style: TextStyle(
                                color: isPhoneSelected
                                    ? appStyle.textColor
                                    : appStyle.primaryColor)),
                      ),
                      false: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text('邮箱找回',
                            style: TextStyle(
                                color: !isPhoneSelected
                                    ? appStyle.textColor
                                    : appStyle.primaryColor)),
                      ),
                    },
                    groupValue: isPhoneSelected,
                    onValueChanged: (bool value) {
                      setState(() {
                        isPhoneSelected = value;
                      });
                    },
                    selectedColor: appStyle.primaryColor,
                    borderColor: appStyle.primaryColor,
                    unselectedColor: appStyle.backgroundColor,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                placeholder: isPhoneSelected ? '请输入您的手机号' : '请输入您的邮箱',
                padding: const EdgeInsets.all(16.0),
                style: TextStyle(color: appStyle.textColor),
                keyboardType: isPhoneSelected
                    ? TextInputType.phone
                    : TextInputType.emailAddress,
                decoration: BoxDecoration(
                  color: appStyle.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: appStyle.primaryColor,
                borderRadius: BorderRadius.circular(15.0),
                onPressed: () {
                  // Navigate to the next step after sending verification code or reset link
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) =>
                        VerificationPage(isPhoneSelected: isPhoneSelected),
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
                    Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    '返回登录',
                    style: TextStyle(
                      fontSize: 16,
                      color: appStyle.primaryColor,
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
    final appStyle = AppStyle(context);
    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Return to the previous page
          },
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          isPhoneSelected ? '输入验证码' : '验证邮箱',
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
                placeholder: isPhoneSelected ? '请输入收到的验证码' : '请输入您的邮箱中的验证码',
                padding: const EdgeInsets.all(16.0),
                style: TextStyle(color: appStyle.textColor),
                keyboardType: TextInputType.number,
                decoration: BoxDecoration(
                  color: appStyle.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: appStyle.primaryColor,
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
