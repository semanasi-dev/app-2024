import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultButton extends StatelessWidget {
  final double width;
  final Function onPressed;
  final double fontSize;
  final String label;

  const DefaultButton({
    super.key,
    required this.width,
    required this.onPressed,
    required this.fontSize,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(0.0),
          elevation: 5,
        ),
        onPressed: () async {
          onPressed();
        },
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF4CC9F0),
                Color(0xFF5458FE),
                Color(0xFF853BF7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize),
            ),
          ),
        ),
      ),
    );
  }
}
