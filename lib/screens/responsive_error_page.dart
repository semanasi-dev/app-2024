import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResponsiveErrorPage extends StatefulWidget {
  const ResponsiveErrorPage({super.key});

  @override
  State<ResponsiveErrorPage> createState() => _ResponsiveErrorPageState();
}

class _ResponsiveErrorPageState extends State<ResponsiveErrorPage> {
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SelectableText(
                  'Desculpe :((, mas este site é otimizado apenas para dispositivos móveis.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: screenSize.aspectRatio * 25,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
