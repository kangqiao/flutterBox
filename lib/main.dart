import 'package:demo/app/router/router_config.dart';
import 'package:demo/views/pages/main/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      showPerformanceOverlay: false, //当为true时应用程序顶部覆盖一层GPU和UI曲线图，可即时查看当前流畅度情况
      debugShowCheckedModeBanner: false, //当为true时，在debug模式下显示右上角的debug字样的横幅，false即为不显示
      checkerboardRasterCacheImages: false, //当为true时，打开光栅缓存图像的棋盘格
      //onGenerateRoute: RouterConfig.generateRoute,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}
