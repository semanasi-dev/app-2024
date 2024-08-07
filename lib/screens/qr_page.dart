import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_reader_web/qrcode_reader_web.dart';
import 'package:sasiqrcode/provider/user_model.dart';
import 'package:sasiqrcode/routes/routes.dart';
import 'package:sasiqrcode/screens/responsive_page.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  bool isLoading = true;

  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRCodeCapture? data;

  final DatabaseReference _database = FirebaseDatabase.instance.ref('users');

  @override
  void initState() {
    super.initState();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return screenSize.width > 600
        ? const ResponsivePage()
        : SafeArea(
            child: Stack(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: screenSize.aspectRatio * 100,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SelectableText(
                                'Aponte a camera para o QR code para garantir os pontos',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.robotoMono(
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontSize: screenSize.aspectRatio * 40,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenSize.height * 0.035,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.8,
                            height: screenSize.height * 0.4,
                            child: QRCodeReaderTransparentWidget(
                              onDetect: (QRCodeCapture capture) async {
                                await atualizaPontuacao(capture.raw);
                                Navigator.pushNamed(
                                    context, Routes.congratulations);
                              },
                              borderRadius: 20,
                              targetSize: 0,
                            ),
                          ),
                        ],
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
              ],
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
