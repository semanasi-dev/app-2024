import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_reader_web/qrcode_reader_web.dart';
import 'package:sasiqrcode/provider/user_model.dart';
import 'package:sasiqrcode/routes/routes.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRCodeCapture? data;

  final DatabaseReference _database = FirebaseDatabase.instance.ref('users');

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                './lib/assets/background.jpeg',
                fit: BoxFit.cover,
                width: constraints.maxWidth,
                height: constraints.maxHeight,
              ),
              Center(
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: QRCodeReaderTransparentWidget(
                    onDetect: (QRCodeCapture capture) async {
                      await atualizaPontuacao(capture.raw);
                      Navigator.pushNamed(context, Routes.congratulations);
                    },
                    borderRadius: 20,
                    targetSize: 0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 150),
                child: const Column(
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Aponte a camera para o QR code para garantir os pontos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none,
                        fontFamily: 'Cristik',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30, left: 30),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (data != null) Text(data!.raw)
            ],
          );
        },
      ),
    );
  }

  Future<void> atualizaPontuacao(String pontos) async {
    User userUid = Provider.of<UserModel>(context, listen: false).userUid!;

    try {
      DatabaseReference userRef = _database.child(userUid.uid);

      DataSnapshot snapshot = await userRef.get();

      if (snapshot.exists) {
        int currentPoints = snapshot.child('pontos').value as int? ?? 0;
        int updatedPoints = currentPoints + (int.tryParse(pontos) ?? 0);

        await userRef.update({
          'pontos': updatedPoints,
          'ultimaCaptura': DateTime.now().toString(),
        });
      } else {
        await userRef.set({
          'pontos': pontos,
          'ultimaCaptura': DateTime.now().toString(),
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating or creating user: $e');
      }
    }
  }
}
