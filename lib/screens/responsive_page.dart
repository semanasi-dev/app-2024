import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResponsivePage extends StatefulWidget {
  const ResponsivePage({super.key});

  @override
  State<ResponsivePage> createState() => _ResponsivePageState();
}

class _ResponsivePageState extends State<ResponsivePage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              './lib/assets/background.jpeg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Center(
              child: SelectableText(
                'Desculpe, mas este site é otimizado apenas para dispositivos móveis.',
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: screenSize.aspectRatio * 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
