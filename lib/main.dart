import 'package:flutter/material.dart';
import 'package:sasiqrcode/routes.dart';
import 'package:sasiqrcode/screens/qr_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MaterCode',
      home: QRPage(),
      initialRoute: Routes.login,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
