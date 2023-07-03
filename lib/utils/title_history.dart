import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryFinanceTitle extends StatelessWidget {
  const HistoryFinanceTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            height: 47,
            decoration: BoxDecoration(
              color: const Color(0xff212436),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        Positioned(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            height: 39,
            decoration: BoxDecoration(
              color: const Color(0xff3B3F58),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 13),
          child: Center(
            child: Text(
              'History Catatan Keuangan',
              style: GoogleFonts.urbanist(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
