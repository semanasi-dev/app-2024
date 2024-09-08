import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sasiqrcode/provider/user_model.dart';
import 'package:sasiqrcode/screens/loading_page.dart';
import 'package:sasiqrcode/screens/responsive_error_page.dart';
import 'package:sasiqrcode/store/login_store.dart';
import 'package:sasiqrcode/widgets/default_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginStore store = LoginStore();

  @override
  void initState() {
    super.initState();
    store.setLoading(true);
    store.state.user = Provider.of<UserModel>(context, listen: false);
    store.setLoading(false, force: true);
    store.update(store.state, force: true);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);

    final double iconSize = screenSize.width * 0.4;
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
                    child: ScopedBuilder<LoginStore, LoginState>(
                      store: store,
                      onLoading: (context) => const LoadingPage(),
                      onState: (context, state) {
                        return Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: iconSize,
                                    height: iconSize,
                                    child: Image.asset(
                                      './lib/assets/logoBranco.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.025,
                                  ),
                                  SelectableText(
                                    'MaterCode 2024',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.robotoMono(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: screenSize.width * 0.08,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.025,
                                  ),
                                  SelectableText(
                                    'Semana acadêmica sistemas de informação 2024',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.robotoMono(
                                      color: Colors.white,
                                      fontSize: screenSize.width * 0.05,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.03,
                                  ),
                                  SelectableText(
                                    'autentique com google para iniciar',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.robotoMono(
                                      color: Colors.white,
                                      fontSize: screenSize.width * 0.03,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  if (state.loginError)
                                    loginError(screenSize)
                                  else
                                    login(screenSize),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget login(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.5,
      height: screenSize.height * 0.045,
      child: ElevatedButton(
        onPressed: () async {
          await store.onClickLogin(context);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              './lib/assets/googleLogo.png',
              width: screenSize.width * 0.1,
              fit: BoxFit.contain,
            ),
            Flexible(
              child: Text(
                'Entrar com google',
                style: GoogleFonts.robotoMono(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.025,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginError(Size screenSize) {
    return Column(
      children: [
        SizedBox(
          height: screenSize.height * 0.025,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            ),
            Text(
              'ERRO INESPERADO',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * 0.03,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: screenSize.height * 0.025,
        ),
        Text(
          'Se você estiver usando o navegador Safari, é necessário trocar para o Google Chrome.',
          textAlign: TextAlign.center,
          style: GoogleFonts.robotoMono(
            color: Colors.white,
            fontSize: screenSize.width * 0.035,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        DefaultButton(
          width: screenSize.width * 0.4,
          onPressed: () {
            store.setLoading(true);
            store.state.loginError = false;
            store.setLoading(false, force: true);
            store.update(store.state, force: true);
          },
          fontSize: screenSize.width * 0.03,
          label: 'Tente novamente',
        ),
      ],
    );
  }
}
