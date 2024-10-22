import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonBack extends StatelessWidget {
  final VoidCallback onTap;

  const ButtonBack({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              size: 15,
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            Text(
              "Back",
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
