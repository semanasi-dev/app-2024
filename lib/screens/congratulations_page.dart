import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sasiqrcode/provider/user_model.dart';
import 'package:sasiqrcode/routes/routes.dart';
import 'package:sasiqrcode/screens/responsive_page.dart';

class CongratulationsPage extends StatefulWidget {
  const CongratulationsPage({super.key});

  @override
  State<CongratulationsPage> createState() => CongratulationsStatePage();
}

class CongratulationsStatePage extends State<CongratulationsPage> {
  bool isLoading = true;
  Future<String>? total;

  @override
  void initState() {
    super.initState();
    total = totalDePontos();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return screenSize.width > 600
        ? const ResponsivePage()
        : SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Image.asset(
                    './lib/assets/background.jpeg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                  Center(
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                './lib/assets/logoBranco.png',
                                fit: BoxFit.cover,
                                width: screenSize.aspectRatio * 330,
                              ),
                              SizedBox(
                                height: screenSize.height * 0.02,
                              ),
                              FutureBuilder<String>(
                                future: total,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator(
                                      color: Colors.white,
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                      'Erro ao carregar pontuação',
                                      style: GoogleFonts.robotoMono(
                                        color: Colors.white,
                                        fontSize: screenSize.aspectRatio * 70,
                                      ),
                                    );
                                  } else {
                                    return SelectableText(
                                      'Pontuação atual: ${snapshot.data ?? '0'}',
                                      style: GoogleFonts.robotoMono(
                                        color: Colors.white,
                                        fontSize: screenSize.aspectRatio * 70,
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: screenSize.height * 0.02,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.home);
                                },
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                child: Text(
                                  'Voltar a tela inicial',
                                  style: GoogleFonts.robotoMono(
                                    color: Colors.black,
                                    fontSize: screenSize.aspectRatio * 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                  )
                ],
              ),
            ),
          );
  }

  Future<String> totalDePontos() async {
    User userUid = Provider.of<UserModel>(context, listen: false).userUid!;

    final DatabaseReference database = FirebaseDatabase.instance.ref('users');

    DatabaseReference userRef = database.child(userUid.uid);
    DataSnapshot snapshot = await userRef.get();

    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    return data['pontos'].toString();
  }
}
