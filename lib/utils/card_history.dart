// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CardHistory extends StatelessWidget {
  String textTitle;
  String textSubTitle;
  String textCounted;
  Color color;

  CardHistory({
    Key? key,
    required this.textTitle,
    required this.textSubTitle,
    required this.textCounted,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        textTitle,
        style: GoogleFonts.urbanist(
          textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis),
        ),
      ),
      subtitle: Text(
        textSubTitle,
        style: GoogleFonts.urbanist(
          textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis),
        ),
      ),
      trailing: Text(
        textCounted,
        style: GoogleFonts.urbanist(
          textStyle: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
