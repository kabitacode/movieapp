import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/utils/theme.dart';

class ButtonProfile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const ButtonProfile(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.openSans(
                color: AppColors.typography,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              icon,
              color: AppColors.typography,
            )
          ],
        ),
      ),
    );
  }
}
