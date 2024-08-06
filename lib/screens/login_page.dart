import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sasiqrcode/provider/user_model.dart';
import 'package:sasiqrcode/routes/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final DatabaseReference database = FirebaseDatabase.instance.ref('users');

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
                            Text(
                              'Bem Vindo',
                              style:
                                  GoogleFonts.robotoMono(color: Colors.white),
                            ),
                            Text(
                              'MaterCode 2024',
                              style:
                                  GoogleFonts.robotoMono(color: Colors.white),
                            ),
                          ],
                        ),
                        Text(
                          'Semana Academica Sistemas de Informacao',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoMono(color: Colors.white),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.05,
                        ),
                        Text(
                          'autentique com google para iniciar',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoMono(color: Colors.white),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        SizedBox(
                          width: screenSize.width * 0.7,
                          height: screenSize.height * 0.05,
                          child: ElevatedButton(
                            onPressed: () async {
                              UserCredential login = await signInWithGoogle();
                              await verificaUsuarioExistente(login);
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
                                Text(
                                  'Entrar com google',
                                  style: GoogleFonts.robotoMono(
                                    color: Colors.black,
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

    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  Future<void> verificaUsuarioExistente(UserCredential login) async {
    if (login.user != null) {
      Provider.of<UserModel>(context, listen: false).setUserUid(login.user);

      DatabaseReference userRef = database.child(login.user!.uid);

      DataSnapshot snapshot = await userRef.get();

      if (!snapshot.exists) {
        await userRef.set({
          'nome': login.user!.displayName,
          'email': login.user!.email,
          'pontos': 0,
        });
      }
      Navigator.pushNamed(context, Routes.home);
    }
  }
}
