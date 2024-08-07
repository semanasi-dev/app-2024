import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sasiqrcode/provider/user_model.dart';
import 'package:sasiqrcode/routes/routes.dart';
import 'package:sasiqrcode/screens/responsive_page.dart';

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
    return screenSize.width > 600
        ? const ResponsivePage()
        : SafeArea(
            child: Scaffold(
              body: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    './lib/assets/background.jpeg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            './lib/assets/logoBranco.png',
                            fit: BoxFit.cover,
                            width: screenSize.aspectRatio * 330,
                          ),
                          SizedBox(
                            height: screenSize.width * 0.025,
                          ),
                          SelectableText(
                            'MaterCode 2024',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.robotoMono(
                              color: Colors.white,
                              fontSize: screenSize.aspectRatio * 80,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.width * 0.025,
                      ),
                      SelectableText(
                        'Semana acadêmica sistemas de informação 2024',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoMono(
                          color: Colors.white,
                          fontSize: screenSize.aspectRatio * 50,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      SelectableText(
                        'autentique com google para iniciar',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoMono(
                          color: Colors.white,
                          fontSize: screenSize.aspectRatio * 30,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      SizedBox(
                        width: screenSize.width * 0.5,
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
                              const Text(
                                'Entrar com google',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
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
