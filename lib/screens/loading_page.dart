import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Image.asset(
                './lib/assets/background.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            const SafeArea(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
