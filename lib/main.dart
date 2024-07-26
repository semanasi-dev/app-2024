import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sasiqrcode/routes/routes.dart';
import 'package:sasiqrcode/screens/qr_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouterApp.generateRoute,
    );
  }
}
