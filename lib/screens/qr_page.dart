import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_reader_web/qrcode_reader_web.dart';
import 'package:sasiqrcode/provider/user_model.dart';
import 'package:sasiqrcode/screens/loading_page.dart';
import 'package:sasiqrcode/screens/responsive_error_page.dart';
import 'package:sasiqrcode/store/qr_store.dart';
import 'package:sasiqrcode/widgets/default_button.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  QrStore store = QrStore();

  @override
  void initState() {
    super.initState();
    store.state.user = Provider.of<UserModel>(context, listen: false).userUid!;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return screenSize.width > 750
        ? const ResponsiveErrorPage()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      './lib/assets/background.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SafeArea(
                    child: ScopedBuilder<QrStore, QrState>(
                      store: store,
                      onLoading: (context) => const LoadingPage(),
                      onState: (context, state) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            qrCodeView(screenSize),
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget qrCodeView(Size screenSize) {
    return store.state.qrCodeInvalidoError || store.state.qrCodeJaLido
        ? invalidQrCode(
            screenSize,
            store.state.qrCodeInvalidoError
                ? 'Desculpe, QR code inválido.'
                : 'Desculpe, mas você já leu este QR Code.')
        : scanQrCode(screenSize);
  }

  Widget scanQrCode(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  width: screenSize.width * 0.5,
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  ),
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
                    fontSize: screenSize.width * 0.045,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.035,
            ),
            SizedBox(
              width: screenSize.width * 0.8,
              height: screenSize.height * 0.55,
              child: QRCodeReaderTransparentWidget(
                onDetect: (QRCodeCapture capture) async {
                  await store.decodeCryptography(capture.raw, context);
                },
                borderRadius: 20,
                targetSize: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget invalidQrCode(Size screenSize, String label) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableText(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoMono(
                color: Colors.white,
                fontSize: screenSize.width * 0.055,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            DefaultButton(
              width: screenSize.width * 0.65,
              onPressed: () {
                store.state.qrCodeInvalidoError = false;
                store.state.qrCodeJaLido = false;
                store.update(store.state, force: true);
              },
              fontSize: screenSize.width * 0.050,
              label: 'Tentar novamente?',
            ),
          ],
        ),
      ),
    );
  }
}
