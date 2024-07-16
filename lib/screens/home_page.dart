import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              './lib/assets/background.jpeg',
              fit: BoxFit.cover,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            ),
            Container(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                  ),
                  // const Expanded(
                  //   flex: 1,
                  //   child: Center(
                  //     child: Text('Scanning...'),
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}
