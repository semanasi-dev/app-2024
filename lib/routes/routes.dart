import 'package:flutter/material.dart';
import 'package:sasiqrcode/screens/congratulations_page.dart';
import 'package:sasiqrcode/screens/home_page.dart';
import 'package:sasiqrcode/screens/info_page.dart';
import 'package:sasiqrcode/screens/login_page.dart';
import 'package:sasiqrcode/screens/qr_page.dart';

class Routes {
  static const login = '/login';
  static const home = '/home';
  static const qrcode = '/qrcode';
  static const info = '/info';
  static const congratulations = '/congratulations';
}

class RouterApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/qrcode':
        return MaterialPageRoute(builder: (_) => const QRPage());
      case '/info':
        return MaterialPageRoute(builder: (_) => const InfoPage());
      case '/congratulations':
        return MaterialPageRoute(builder: (_) => const CongratulationsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
    }
  }
}
