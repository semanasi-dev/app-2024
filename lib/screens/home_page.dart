import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: Stack(
          children: [
            Image.asset(
              './lib/assets/background.jpeg',
              fit: BoxFit.cover,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            ),
            Column(
              children: [],
            )
          ],
        ),
      );
    });
  }
}
