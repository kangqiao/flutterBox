import 'package:demo/app/router/router_utils.dart';
import 'package:demo/views/pages/setting/setting_page.dart';
import 'package:flutter/material.dart';

class RouterConfig {
  static const String setting = 'SettingPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case setting:
        return Right2LeftRouter(child: SettingPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
