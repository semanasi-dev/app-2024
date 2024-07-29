import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_reader_web/qrcode_reader_web.dart';
import 'package:sasiqrcode/provider/user_model.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRCodeCapture? data;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
                    onDetect: (QRCodeCapture capture) => setState(
                        () async => await atualizaPontuacao(capture.raw)),
                    targetSize: 250,
                    //radius: 20,
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
                          decoration: TextDecoration.none),
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

    DocumentReference documentReference =
        _firestore.collection('users').doc(userUid.uid);

    DocumentSnapshot documentSnapshot = await documentReference.get();

    if (documentSnapshot.exists) {
      int currentValue = documentSnapshot['pontos'] ?? 0;
      int updatedValue = currentValue + int.tryParse(pontos)!;

      try {
        await documentReference.update({'pontos': updatedValue});
      } catch (e) {
        print('Error updating document: $e');
      }
    } else {
      try {
        await documentReference.set({
          'pontos': pontos,
        });
      } catch (e) {
        print('Error creating document: $e');
      }
    }
  }
}
