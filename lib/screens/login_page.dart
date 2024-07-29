import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasiqrcode/provider/user_model.dart';
import 'package:sasiqrcode/routes/routes.dart';
import 'package:sasiqrcode/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  final AuthenticationService authService;
  const LoginPage({super.key, required this.authService});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    './lib/assets/background.jpeg',
                    fit: BoxFit.cover,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('./lib/assets/logoBranco.png',
                                fit: BoxFit.cover,
                                width: screenSize.width * 0.3),
                            SizedBox(
                              height: screenSize.height * 0.025,
                            ),
                            const Text(
                              'Bem Vindo',
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontSize: 30,
                              ),
                            ),
                            const Text(
                              'MaterCode 2024',
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Semana Academica Sistemas de Informacao',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.05,
                        ),
                        const Text(
                          'autentique com google para comecar a pontuar',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        SizedBox(
                          width: screenSize.width * 0.7,
                          height: screenSize.height * 0.05,
                          child: ElevatedButton(
                            onPressed: () async {
                              var login = await signInWithGoogle();
                              if (login.user != null) {
                                Provider.of<UserModel>(context, listen: false)
                                    .setUserUid(login.user);
                                Navigator.pushNamed(context, Routes.home);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  './lib/assets/googleLogo.png',
                                  width: screenSize.width * 0.08,
                                  fit: BoxFit.fill,
                                ),
                                const Text(
                                  'Entrar com google',
                                  style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }
}
