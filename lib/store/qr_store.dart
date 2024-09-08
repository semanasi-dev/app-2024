import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:qrcode_reader_web/qrcode_reader_web.dart';
import 'package:sasiqrcode/routes/routes.dart';

class QrState {
  bool qrCodeInvalidoError = false;
  bool qrCodeJaLido = false;

  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRCodeCapture? data;

  final DatabaseReference _database = FirebaseDatabase.instance.ref('users');

  User? user;
}

class QrStore extends Store<QrState> {
  QrStore() : super(QrState());

  Future<void> updateScore(String qrcode, String pontos) async {
    DatabaseReference userRef = state._database.child(state.user!.uid);

    DataSnapshot snapshot = await userRef.get();

    if (snapshot.exists) {
      int currentPoints = snapshot.child('pontos').value as int? ?? 0;
      int updatedPoints = currentPoints + (int.tryParse(pontos) ?? 0);

      List<dynamic> qrCodesLidos =
          (snapshot.child('qrCodesLidos').value as List<dynamic>?) ?? [];

      if (qrCodesLidos.contains(qrcode)) {
        state.qrCodeJaLido = true;
        update(state, force: true);
        return;
      }

      qrCodesLidos.add(qrcode);

      await userRef.update({
        'pontos': updatedPoints,
        'ultimaCaptura': DateTime.now().toString(),
        'qrCodesLidos': qrCodesLidos,
      });
    } else {
      await userRef.set({
        'pontos': pontos,
        'ultimaCaptura': DateTime.now().toString(),
        'qrCodesLidos': [qrcode],
      });
    }
  }

  Future<void> decodeCryptography(
      String cryptography, BuildContext context) async {
    String encryptedPart = cryptography;
    int tamanhoCriptografado = encryptedPart.length;

    int countS = 'S'.allMatches(encryptedPart).length;
    int countA = 'A'.allMatches(encryptedPart).length;
    int countI = 'I'.allMatches(encryptedPart).length;

    if (countS == 2 && countA == 1 && countI == 1) {
      String result = cryptography.substring(
          tamanhoCriptografado - 3, tamanhoCriptografado);
      await updateScore(cryptography, result);
      if (state.qrCodeJaLido) return;
      RouterUtils().navigatorToCongratulations(context);
    } else {
      state.qrCodeInvalidoError = true;
      update(state, force: true);
    }
  }
}
