import 'dart:developer';

import 'package:demo/views/pages/assets/assets_page.dart';
import 'package:demo/views/pages/dapp/dapp_page.dart';
import 'package:demo/views/pages/home/home_page.dart';
import 'package:demo/views/pages/market/market_page.dart';
import 'package:demo/views/pages/my/my_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  List<Widget> _homeWidgets = [
    HomePage(),
    AssetsPage(),
    DAppPage(),
    MarketPage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DefiBox'),
      ),
      body: IndexedStack(
        index: _index,
        children: _homeWidgets,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: _onBottomNavigationBarTapped,
        items: [
          _getBottomNavItem('首页', 'assets/images/home.png', 'assets/images/home_hover.png', 0),
          _getBottomNavItem('资产', 'assets/images/assets.png', 'assets/images/assets_hover.png', 1),
          _getBottomNavItem('应用概览', 'assets/images/dapp.png', 'assets/images/dapp_hover.png', 2),
          _getBottomNavItem('币种行情', 'assets/images/market.png', 'assets/images/market_hover.png', 3),
          _getBottomNavItem('我的', 'assets/images/my.png', 'assets/images/my_hover.png', 4),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSwitch,
        tooltip: '切换',
        child: Icon(Icons.swap_horizontal_circle_outlined),
      ),
    );
  }

  void _onBottomNavigationBarTapped(index) {
    setState(() {
      _index = index;
    });
  }

  BottomNavigationBarItem _getBottomNavItem(String title, String normalIcon, String pressedIcon, int index) {
    return BottomNavigationBarItem(
      icon: _index == index ? Image.asset(
        pressedIcon,
        width: 26,
        height: 26,
      )
          : Image.asset(
        normalIcon,
        width: 26,
        height: 26,
      ),
      label: title,
    );
  }

  void _onSwitch() {
    //todo 未实现
    log('_onSwitch');
  }
}