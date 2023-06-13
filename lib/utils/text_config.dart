// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MainText extends StatelessWidget {
  double fontSize;
  Color color;
  FontWeight fontWeight;
  String text;
  MainText({
    Key? key,
    required this.fontSize,
    required this.color,
    required this.fontWeight,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.urbanist(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
