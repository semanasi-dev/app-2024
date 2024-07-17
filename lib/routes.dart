import 'package:flutter/material.dart';
import 'package:sasiqrcode/screens/home_page.dart';
import 'package:sasiqrcode/screens/login_page.dart';
import 'package:sasiqrcode/screens/qr_page.dart';

class Routes {
  static const login = '/login';
  static const home = '/home';
  static const qrcode = '/qrcode';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/qrcode':
        return MaterialPageRoute(builder: (_) => QRPage());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
