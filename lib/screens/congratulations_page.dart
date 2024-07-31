import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasiqrcode/provider/user_model.dart';
import 'package:sasiqrcode/routes/routes.dart';

class CongratulationsPage extends StatefulWidget {
  const CongratulationsPage({super.key});

  @override
  State<CongratulationsPage> createState() => CongratulationsStatePage();
}

class CongratulationsStatePage extends State<CongratulationsPage> {
  String? total;

  @override
  void initState() {
    super.initState();
    totalDePontos();
  }

  @override
  Widget build(BuildContext context) {
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
                        Text(
                          'Parabens $total',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cristik',
                            fontSize: 40,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.home);
                          },
                          child: const Text(
                            'Voltar a home',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Cristik',
                              fontSize: 30,
                            ),
                          ),
                        )
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
