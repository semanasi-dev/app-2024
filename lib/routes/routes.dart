import 'package:flutter/material.dart';
import 'package:sasiqrcode/screens/congratulations_page.dart';
import 'package:sasiqrcode/screens/home_page.dart';
import 'package:sasiqrcode/screens/info_page.dart';
import 'package:sasiqrcode/screens/login_page.dart';
import 'package:sasiqrcode/screens/qr_page.dart';
import 'package:sasiqrcode/screens/ranking_page.dart';

class Routes {
  static const login = '/login';
  static const home = '/home';
  static const qrcode = '/qrcode';
  static const info = '/info';
  static const congratulations = '/congratulations';
  static const ranking = '/ranking';
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
      case '/ranking':
        return MaterialPageRoute(
          builder: (context) => const RankingPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
    }
  }
}

class RouterUtils {
  navigatorToHome(BuildContext context) {
    Navigator.pushNamed(context, Routes.home);
  }

  navigatorToCongratulations(BuildContext context) {
    Navigator.pushNamed(context, Routes.congratulations);
  }
}
