import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasiqrcode/provider/user_model.dart';
import 'package:sasiqrcode/routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? total;

  @override
  void initState() {
    super.initState();
    totalDePontos();
  }

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
                children: [
                  Image.asset(
                    './lib/assets/background.jpeg',
                    fit: BoxFit.cover,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                  ),
                  Center(
                    child: Column(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  size: screenSize.width * 0.2,
                                ),
                                Text(
                                  'Informacoes',
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontSize: screenSize.width * 0.08,
                                    fontFamily: 'Cristik',
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.qr_code_2_outlined,
                                  size: screenSize.width * 0.25,
                                ),
                                Text(
                                  'Ler QrCode',
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontSize: screenSize.width * 0.08,
                                    fontFamily: 'Cristik',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.05,
                        ),
                        Text(
                          total!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: 'Cristik'),
                        ),
                        const Text(
                          'Pontuacao atual',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'Cristik',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> totalDePontos() async {
    User userUid = Provider.of<UserModel>(context, listen: false).userUid!;

    final DatabaseReference database = FirebaseDatabase.instance.ref('users');

    DatabaseReference userRef = database.child(userUid.uid);
    DataSnapshot snapshot = await userRef.get();

    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    setState(() {
      total = data['pontos'].toString();
    });
  }
}
