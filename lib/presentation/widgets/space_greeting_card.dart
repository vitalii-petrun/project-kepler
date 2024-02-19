import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

class SpaceGreetingCard extends StatelessWidget {
  const SpaceGreetingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/welcome.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16.0),
          Text(
            context.l10n.welcomeToApp,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.oswald().fontFamily,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            context.l10n.spaceGreeting,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontFamily: GoogleFonts.oswald().fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
