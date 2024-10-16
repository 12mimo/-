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
          // 添加选中的页面
          pages[_selectedIndex],

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  height: 60.0, // 调整高度，使 TabBar 看起来更紧凑
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF37474F).withOpacity(0.9) : const Color(0xFFB2EBF2).withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode
                            ? CupertinoColors.black.withOpacity(0.3)
                            : CupertinoColors.systemGrey.withOpacity(0.2),
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0), // 设置上下 Padding，使内容居中
                    child: CupertinoTabBar(
                      backgroundColor: CupertinoColors.transparent,
                      activeColor: isDarkMode ? const Color(0xFF80CBC4) : const Color(0xFF00838F),
                      inactiveColor: isDarkMode ? const Color(0xFFB0BEC5) : const Color(0xFF80DEEA),
                      iconSize: 26.0,
                      currentIndex: _selectedIndex,
                      onTap: _onTabTapped,
                      border: null,
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.house_fill),
                          label: '主页',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.heart_circle_fill),
                          label: '心灵顾问',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.person_crop_circle_fill),
                          label: '个人中心',
                        ),
                      ],
                    ),
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