import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/utils/ui_helpers.dart';

class SpaceGreetingCard extends StatefulWidget {
  final User? user;
  const SpaceGreetingCard({Key? key, this.user}) : super(key: key);

  @override
  SpaceGreetingCardState createState() => SpaceGreetingCardState();
}

class SpaceGreetingCardState extends State<SpaceGreetingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: widget.user != null
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.2),
                ),
              ],
            )
          : BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/welcome.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(16.0),
            ),
      child: FadeTransition(
        opacity: _animation,
        child: widget.user != null
            ? Text(
                context.l10n.welcomeBack(widget.user!.displayName!),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.oswald().fontFamily,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 126.0),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Text(
                      context.l10n.welcomeToApp,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.oswald().fontFamily,
                      ),
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
                  const SizedBox(height: 16.0),
                ],
              ),
      ),
    );
  }
}
