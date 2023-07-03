// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AddFinance extends StatelessWidget {
  String title;
  String image;
  AddFinance({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 75,
          height: 75,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff2A3547),
          ),
          child: Center(
            child: Image.asset(image),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          title,
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
