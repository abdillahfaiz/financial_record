import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://media.licdn.com/dms/image/C5603AQGapBlxJ88m0w/profile-displayphoto-shrink_800_800/0/1660779441034?e=2147483647&v=beta&t=P_VI22y4wyi_xphcg4XQTmez3Mfn0EXE_mjOCJXqmb8'),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              'Abdillah Faiz',
              style: GoogleFonts.urbanist(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      ],
    );
  }
}
