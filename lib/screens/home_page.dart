import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sasiqrcode/provider/user_model.dart';

import 'package:sasiqrcode/routes/routes.dart';
import 'package:sasiqrcode/screens/responsive_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    './lib/assets/background.jpeg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.info);
                              },
                              child: Container(
                                height: screenSize.height * 0.25,
                                width: screenSize.width * 0.55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blueAccent,
                                    width: screenSize.width * 0.015,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.info_outline_rounded,
                                      size: screenSize.aspectRatio * 250,
                                    ),
                                    SelectableText(
                                      'informações',
                                      style: GoogleFonts.robotoMono(
                                        color: Colors.black,
                                        fontSize: screenSize.aspectRatio * 50,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.05,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.qrcode);
                              },
                              child: Container(
                                height: screenSize.height * 0.25,
                                width: screenSize.width * 0.55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blueAccent,
                                    width: screenSize.width * 0.015,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.qr_code_2_outlined,
                                      size: screenSize.aspectRatio * 250,
                                    ),
                                    SelectableText(
                                      'Ler QrCode',
                                      style: GoogleFonts.robotoMono(
                                        color: Colors.black,
                                        fontSize: screenSize.aspectRatio * 50,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.05,
                            ),
                            SelectableText(
                              'Pontuação atual',
                              style: GoogleFonts.robotoMono(
                                color: Colors.white,
                                fontSize: screenSize.aspectRatio * 50,
                              ),
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
                                    snapshot.data ?? '0',
                                    style: GoogleFonts.robotoMono(
                                      color: Colors.white,
                                      fontSize: screenSize.aspectRatio * 70,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
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
