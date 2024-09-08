import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sasiqrcode/provider/user_model.dart';
import 'package:sasiqrcode/routes/routes.dart';
import 'package:sasiqrcode/screens/loading_page.dart';
import 'package:sasiqrcode/screens/responsive_error_page.dart';
import 'package:sasiqrcode/store/home_store.dart';
import 'package:sasiqrcode/widgets/default_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = HomeStore();

  @override
  void initState() {
    super.initState();
    store.state.userUid =
        Provider.of<UserModel>(context, listen: false).userUid!;
    store.init();
  }

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
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return ScopedBuilder<HomeStore, HomeState>(
                        store: store,
                        onLoading: (context) {
                          return const LoadingPage();
                        },
                        onState: (context, state) {
                          return SafeArea(
                            child: SingleChildScrollView(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: constraints.maxHeight * 0.05,
                                    ),
                                    Column(
                                      children: [
                                        SelectableText(
                                          'Bem-vindo(a),',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.robotoMono(
                                            color: Colors.white,
                                            fontSize: screenSize.width * 0.05,
                                          ),
                                        ),
                                        SelectableText(
                                          '${state.userUid!.displayName}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.robotoMono(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: screenSize.width * 0.05,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.03,
                                    ),
                                    optionButton(
                                      context,
                                      'Informações',
                                      Icons.info_outline_rounded,
                                      Routes.info,
                                      screenSize,
                                    ),
                                    SizedBox(
                                        height: constraints.maxHeight * 0.03),
                                    optionButton(
                                      context,
                                      'Ler QR code',
                                      Icons.qr_code_2_outlined,
                                      Routes.qrcode,
                                      screenSize,
                                    ),
                                    SizedBox(
                                        height: constraints.maxHeight * 0.03),
                                    optionButton(
                                      context,
                                      'Ranking',
                                      Icons.emoji_events_outlined,
                                      Routes.ranking,
                                      screenSize,
                                    ),
                                    SizedBox(
                                        height: constraints.maxHeight * 0.03),
                                    const Divider(
                                      color: Colors.white,
                                      thickness: 3,
                                    ),
                                    SizedBox(
                                        height: constraints.maxHeight * 0.03),
                                    linkedinPreview(screenSize),
                                    SizedBox(
                                        height: constraints.maxHeight * 0.03),
                                    Column(
                                      children: [
                                        SelectableText(
                                          'Sua pontuação atual:',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.robotoMono(
                                            color: Colors.white,
                                            fontSize: screenSize.width * 0.07,
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.010,
                                        ),
                                        SelectableText(
                                          store.state.total!,
                                          style: GoogleFonts.robotoMono(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: screenSize.width * 0.07,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }

  Widget linkedinPreview(Size screenSize) {
    return store.state.jaValidouLinkedin ?? false
        ? SelectableText(
            'Você já validou seu Linkedin, muito obrigado!',
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenSize.width * 0.04,
            ),
          )
        : insiraSeuLinkedin(screenSize);
  }

  Widget optionButton(BuildContext context, String label, IconData icon,
      String route, Size screenSize) {
    return SizedBox(
      width: double.maxFinite,
      height: screenSize.height * 0.09,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(double.maxFinite, screenSize.height * 0.09),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: Colors.blueAccent,
              width: screenSize.width * 0.007,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Icon(
                icon,
                size: screenSize.width * 0.08,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.robotoMono(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: screenSize.width * 0.04,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Icon(
                Icons.keyboard_arrow_right_outlined,
                size: screenSize.width * 0.08,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget insiraSeuLinkedin(Size screenSize) {
    return Column(
      children: [
        SelectableText(
          'Insira a URL do seu LinkedIn para ganhar 50 pontos!!',
          textAlign: TextAlign.center,
          style: GoogleFonts.robotoMono(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenSize.width * 0.035,
          ),
        ),
        SizedBox(
          height: screenSize.height * 0.030,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              './lib/assets/linkedin.png',
              width: screenSize.width * 0.09,
              height: screenSize.height * 0.06,
              fit: BoxFit.fill,
              color: Colors.white,
            ),
            SizedBox(
              width: screenSize.width * 0.015,
            ),
            SizedBox(
              width: screenSize.width * 0.8,
              child: TextField(
                controller: store.state.linkedinController,
                decoration: InputDecoration(
                  hintText: 'Digite aqui',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: screenSize.height * 0.030,
        ),
        DefaultButton(
          width: double.maxFinite,
          onPressed: () async {
            await store.addLinkedin(store.state.linkedinController.text);
            store.state.jaValidouLinkedin = true;
            setState(() => ());
          },
          label: 'Submeter Linkedin',
          fontSize: screenSize.width * 0.03,
        ),
      ],
    );
  }
}
