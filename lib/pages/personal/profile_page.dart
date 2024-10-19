import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../store/global.dart';
import '../../styles/color.dart';
import '../../styles/index.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    Map<String, dynamic> user =
        (context.watch<GlobalState>().user as Map).cast<String, dynamic>();
    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor,
          ),
        ),
        middle: Text(
          '个人资料',
          style: TextStyle(
            color: appStyle.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: appStyle.backgroundColor,
      ),
      child: CupertinoScrollbar(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildAvatarSection(user, appStyle.contentColor, context),
            // 将头像部分置于页面最上方
            const SizedBox(height: 20),
            // 添加一些间距
            _buildFullWidthSection(
              _buildPersonalInfoSection(user, appStyle.primaryColor,
                  appStyle.contentColor, appStyle.cardBackgroundColor, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSection(user, Color contentColor, BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _uploadAvatar(context); // 点击头像上传新头像
          },
          child: CircleAvatar(
            radius: 50, // 设置头像的大小
            backgroundImage: NetworkImage("${user['avatar']}"), // 默认头像图片
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '点击更换头像',
          style: TextStyle(
            fontSize: 16,
            color: contentColor.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  // 模拟上传头像的功能
  void _uploadAvatar(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('上传头像'),
          content: Text('这里可以实现上传头像的功能'),
          actions: [
            CupertinoDialogAction(
              child: Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildFullWidthSection(Widget child) {
    return SizedBox(
      width: double.infinity,
      child: child,
    );
  }

  Widget _buildPersonalInfoSection(user, Color primaryColor, Color contentColor,
      Color cardBackgroundColor, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            cardBackgroundColor.withOpacity(0.9),
            cardBackgroundColor.withOpacity(0.7)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // 修复溢出问题，设置为最小尺寸
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => NicknameEditPage(),
                ),
              );
            },
            child: _buildSettingItem('昵称', CupertinoIcons.person, contentColor,
                '${user['nickname']}'),
          ),
          const Divider(height: 20, thickness: 1),
          _buildSettingItemWithLimitedEdit('性别', CupertinoIcons.person_2,
              contentColor, '${user['sex']}', context, (newGender) {
            // 在这里保存修改后的性别
          }, isGender: true, isEditable: user['sex'] == null), // 仅允许修改一次
          const Divider(height: 20, thickness: 1),
          _buildSettingItemWithLimitedEdit('生日', CupertinoIcons.calendar,
              contentColor, "${user['birthday']}", context, (newDate) {
            // 在这里保存修改后的生日
          }, isDate: true, isEditable: user['birthday'] == null), // 仅允许修改一次
          const Divider(height: 20, thickness: 1),
          _buildSettingItem('星座', CupertinoIcons.star, contentColor,
              _calculateZodiacSign(user['birthday'])),
          const Divider(height: 20, thickness: 1),
          _buildSettingItem(
              'MBTI', CupertinoIcons.mail, contentColor, '${user['mbti']}'),
          const Divider(height: 20, thickness: 1),
          _buildSettingItem('位置', CupertinoIcons.location, contentColor,
              '${user['location']}'),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
      String label, IconData icon, Color contentColor, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: contentColor.withOpacity(0.7),
            size: 28,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: contentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            data,
            style: TextStyle(
              fontSize: 16,
              color: contentColor.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItemWithLimitedEdit(
      String label,
      IconData icon,
      Color contentColor,
      String data,
      BuildContext context,
      Function(String) onSave,
      {bool isGender = false,
      bool isDate = false,
      bool isEditable = true}) {
    if (!isEditable) {
      return _buildSettingItem(label, icon, contentColor, data);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: contentColor.withOpacity(0.7),
            size: 28,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: contentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (isGender)
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(
                data,
                style: TextStyle(
                  fontSize: 16,
                  color: contentColor.withOpacity(0.9),
                ),
              ),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      title: Text('选择性别'),
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () {
                            onSave('男');
                            Navigator.pop(context);
                          },
                          child: Text('男'),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () {
                            onSave('女');
                            Navigator.pop(context);
                          },
                          child: Text('女'),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('取消'),
                      ),
                    );
                  },
                );
              },
            )
          else if (isDate)
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(
                data,
                style: TextStyle(
                  fontSize: 16,
                  color: contentColor.withOpacity(0.9),
                ),
              ),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    DateTime selectedDate =
                        DateTime.tryParse(data) ?? DateTime.now();
                    return Container(
                      height: 300, // 增加日期选择器的高度以避免溢出
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // 修复溢出问题
                        children: [
                          SizedBox(
                            height: 200,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (DateTime newDate) {
                                onSave('${newDate.toLocal()}'.split(' ')[0]);
                              },
                            ),
                          ),
                          CupertinoButton(
                            child: Text('确定'),
                            onPressed: () {
                              onSave('${selectedDate.toLocal()}'.split(' ')[0]);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            )
        ],
      ),
    );
  }

  String _calculateZodiacSign(String birthday) {
    DateTime date = DateTime.tryParse(birthday) ?? DateTime.now();
    int month = date.month;
    int day = date.day;

    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      return "水瓶座";
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      return "双鱼座";
    } else if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
      return "白羊座";
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      return "金牛座";
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      return "双子座";
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      return "巨蟹座";
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      return "狮子座";
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      return "处女座";
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      return "天秤座";
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      return "天蝎座";
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      return "射手座";
    } else {
      return "摩羯座";
    }
  }
}

class NicknameEditPage extends StatelessWidget {
  const NicknameEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    Map<String, dynamic> user =
        (context.watch<GlobalState>().user as Map).cast<String, dynamic>();
    TextEditingController nicknameController =
        TextEditingController(text: user['nickname']);

    return CupertinoPageScaffold(
      backgroundColor: appStyle.backgroundColor, // 使用背景色
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: appStyle.primaryColor, // 使用文本颜色
          ),
        ),
        middle: Text(
          '修改昵称',
          style: TextStyle(
            color: appStyle.primaryColor, // 使用文本颜色
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: appStyle.backgroundColor, // 使用背景色
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '请输入新的昵称',
              style: TextStyle(
                fontSize: 18,
                color: appStyle.contentColor, // 使用内容颜色
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            CupertinoTextField(
              controller: nicknameController,
              placeholder: '新的昵称',
              placeholderStyle: TextStyle(
                color: appStyle.textColor.withOpacity(0.5), // 使用透明的文本颜色
              ),
              style: TextStyle(
                color: appStyle.textColor, // 使用文本颜色
              ),
              decoration: BoxDecoration(
                color: appStyle.cardBackgroundColor, // 使用卡片背景颜色
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: appStyle.textColor.withOpacity(0.3), // 使用带透明度的文本颜色
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                onPressed: () {
                  // 保存新的昵称逻辑
                  Navigator.pop(context);
                },
                color: appStyle.primaryColor,
                // 使用主色调作为按钮颜色
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                borderRadius: BorderRadius.circular(8),
                child: Text(
                  '保存',
                  style: TextStyle(
                    color: appStyle.backgroundColor, // 按钮文本颜色使用背景色，以增加对比
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
