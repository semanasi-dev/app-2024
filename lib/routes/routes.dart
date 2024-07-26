import 'package:flutter/material.dart';
import 'package:sasiqrcode/screens/home_page.dart';
import 'package:sasiqrcode/screens/info_page.dart';
import 'package:sasiqrcode/screens/login_page.dart';
import 'package:sasiqrcode/screens/qr_page.dart';
import 'package:sasiqrcode/service/auth_service.dart';

class Routes {
  static const login = '/login';
  static const home = '/home';
  static const qrcode = '/qrcode';
  static const info = '/info';
}

class RouterApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) =>
              LoginPage(authService: AuthenticationService.instance),
        );
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/qrcode':
        return MaterialPageRoute(builder: (_) => const QRPage());
      case '/info':
        return MaterialPageRoute(builder: (_) => const InfoPage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              LoginPage(authService: AuthenticationService.instance),
        );
    }
  }
}
