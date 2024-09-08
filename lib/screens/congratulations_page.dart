import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sasiqrcode/provider/user_model.dart';
import 'package:sasiqrcode/routes/routes.dart';
import 'package:sasiqrcode/screens/loading_page.dart';
import 'package:sasiqrcode/screens/responsive_error_page.dart';
import 'package:sasiqrcode/store/congratulations_store.dart';
import 'package:sasiqrcode/widgets/default_button.dart';

class CongratulationsPage extends StatefulWidget {
  const CongratulationsPage({super.key});

  @override
  State<CongratulationsPage> createState() => CongratulationsStatePage();
}

class CongratulationsStatePage extends State<CongratulationsPage> {
  CongratulationsStore store = CongratulationsStore();

  @override
  void initState() {
    super.initState();
    store.state.user = Provider.of<UserModel>(context, listen: false).userUid!;
    store.init();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return screenSize.width > 750
        ? const ResponsiveErrorPage()
        : SafeArea(
            child: Scaffold(
              body: ScopedBuilder<CongratulationsStore, CongratulationsState>(
                store: store,
                onLoading: (context) => const LoadingPage(),
                onState: (context, state) {
                  return Stack(
                    children: [
                      Image.asset(
                        './lib/assets/background.jpeg',
                        fit: BoxFit.cover,
                        height: double.maxFinite,
                        width: double.maxFinite,
                      ),
                      Center(
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
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SelectableText(
                                    'Pontuação atual:',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.robotoMono(
                                      color: Colors.white,
                                      fontSize: screenSize.aspectRatio * 70,
                                    ),
                                  ),
                                  SelectableText(
                                    state.total ?? '0',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.robotoMono(
                                      color: Colors.white,
                                      fontSize: screenSize.aspectRatio * 70,
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            DefaultButton(
                              width: screenSize.width * 0.55,
                              onPressed: () {
                                RouterUtils().navigatorToHome(context);
                              },
                              fontSize: screenSize.aspectRatio * 35,
                              label: 'Voltar a tela inicial',
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
  }
}
