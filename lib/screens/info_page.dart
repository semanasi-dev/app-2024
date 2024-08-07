import 'package:flutter/material.dart';
import 'package:sasiqrcode/screens/responsive_page.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return screenSize.width > 600
        ? const ResponsivePage()
        : SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Image.asset(
                    './lib/assets/background.jpeg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ],
              ),
            ),
          );
  }
}
