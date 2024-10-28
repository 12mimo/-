import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:xlfz/pages/consultant/index.dart';
import 'package:xlfz/pages/index/index.dart';
import 'package:xlfz/pages/personal/profile.dart';
import 'package:xlfz/store/global.dart';
import 'package:xlfz/utils/sys.dart';
import 'package:flutter/foundation.dart';

void main() {
  print('Is this running on the web? $kIsWeb');
  // RequestMultiplePermissions().requestMultiplePermissions();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalState()), // 提供全局状态
      ],
      child: CupertinoStoreApp(),
    ),
  );
}

class CupertinoStoreApp extends StatelessWidget {
  const CupertinoStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
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
  final NetworkUtil _networkUtil = NetworkUtil();

  @override
  void initState() {
    super.initState();
    _networkUtil.checkConnectivity();
  }

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
    final List<Widget> pages = const [
      HomePage(),
      VirtualConsultantPage(),
      ProfilePage(),
    ];

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor:
            isDarkMode ? const Color(0xFF37474F) : const Color(0xFFB2EBF2),
        activeColor:
            isDarkMode ? const Color(0xFF80CBC4) : const Color(0xFF00838F),
        inactiveColor:
            isDarkMode ? const Color(0xFFB0BEC5) : const Color(0xFF80DEEA),
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book_circle_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart_circle_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_crop_circle_fill),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoPageScaffold(
          backgroundColor:
              isDarkMode ? const Color(0xFF263238) : const Color(0xFFE0F7FA),
          child: pages[index],
        );
      },
    );
  }
}
