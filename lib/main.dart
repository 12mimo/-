import 'package:flutter/cupertino.dart';
import 'package:xlfz/pages/consultant/index.dart';
import 'package:xlfz/pages/index/index.dart';
import 'package:xlfz/pages/personal/profile.dart';

void main() {
  runApp(const CupertinoStoreApp());
}

class CupertinoStoreApp extends StatelessWidget {
  const CupertinoStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: MediaQuery.of(context).platformBrightness,
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: const CupertinoStoreHomePage(),
    );
  }
}

class CupertinoStoreHomePage extends StatefulWidget {
  const CupertinoStoreHomePage({super.key});

  @override
  CupertinoStoreHomePageState createState() => CupertinoStoreHomePageState();
}

class CupertinoStoreHomePageState extends State<CupertinoStoreHomePage> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    // 自定义页面列表
    final List<Widget> pages = [
      const HomePage(),
      const VirtualConsultantPage(),
      const ProfilePage(),
    ];

    return CupertinoPageScaffold(
      backgroundColor: isDarkMode ? const Color(0xFF263238) : const Color(0xFFE0F7FA),
      child: Stack(
        children: [
          pages[_selectedIndex],  // 选中的页面

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0), // 增加底部 padding，使椭圆 TabBar 悬浮
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0), // 使背景变为椭圆形
                child: Container(
                  height: 70.0, // 设置容器高度
                  width: MediaQuery.of(context).size.width * 0.9, // 设置宽度为屏幕的 90%
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF37474F).withOpacity(0.9) : const Color(0xFFB2EBF2).withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode
                            ? CupertinoColors.black.withOpacity(0.3)
                            : CupertinoColors.systemGrey.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: CupertinoTabBar(
                    backgroundColor: CupertinoColors.transparent, // 背景设置为透明
                    activeColor: isDarkMode ? const Color(0xFF80CBC4) : const Color(0xFF00838F),
                    inactiveColor: isDarkMode ? const Color(0xFFB0BEC5) : const Color(0xFF80DEEA),
                    iconSize: 28.0, // 增大图标尺寸，提升可点击性
                    currentIndex: _selectedIndex,
                    onTap: _onTabTapped,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.house_fill),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.heart_circle_fill),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.person_crop_circle_fill),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

