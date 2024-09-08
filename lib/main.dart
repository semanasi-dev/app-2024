import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:sasiqrcode/provider/user_model.dart';
import 'package:sasiqrcode/routes/routes.dart';
import 'package:sasiqrcode/screens/loading_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoadingPage(),
          );
        } else {
          return ChangeNotifierProvider(
            create: (_) => UserModel(),
            child: const MaterialApp(
              title: 'MaterCode',
              initialRoute: Routes.login,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouterApp.generateRoute,
            ),
          );
        }
      },
    );
  }

  Future<void> initializeFirebase() async {
    await dotenv.load(fileName: ".env");
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_API_KEY']!,
        authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
        appId: dotenv.env['FIREBASE_APP_ID']!,
        measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID']!,
        databaseURL: dotenv.env['FIREBASE_DATABASE_URL']!,
      ),
    );
  }
}
