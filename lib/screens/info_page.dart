import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sasiqrcode/screens/responsive_error_page.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return screenSize.width > 750
        ? const ResponsiveErrorPage()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              height: double.maxFinite,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      './lib/assets/background.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SafeArea(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.4,
                                height: screenSize.width * 0.4,
                                child: Image.asset(
                                  './lib/assets/logoBranco.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SelectableText(
                                'Bem-vindo ao site da Semana Acadêmica de 2024 do curso de Sistemas de Informação! A gamificação deste evento é simples e empolgante: use seu celular para capturar o QR Code exibido na tela e acumule pontos. Os três primeiros colocados no final da semana serão premiados com prêmios especiais!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.robotoMono(
                                  color: Colors.white,
                                  fontSize: screenSize.width * 0.04,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SelectableText(
                                'Então, não perca tempo: aponte sua câmera, capture o QR Code e comece a competir. Boa sorte e divirta-se!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.robotoMono(
                                  color: Colors.white,
                                  fontSize: screenSize.width * 0.04,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                ],
              ),
            ),
          );
  }
}
