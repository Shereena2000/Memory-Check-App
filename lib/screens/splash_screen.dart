import 'package:flip_card/screens/game_screen.dart';
import 'package:flip_card/utils/colors_constand.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      Future.delayed(const Duration(seconds: 2), () {
      if (mounted) { // Ensures widget is still in the tree before navigation
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const GameScreen()),
        );
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: RotatedBox(
                  quarterTurns: 3, 
                  child: Text(
                    "FLIP\nCARDS",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.orbitron(
                      fontSize: 120,
                      fontWeight: FontWeight.bold,
                      color: lightPurpleColor, 
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),

            // Loading Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: LinearProgressIndicator(
                value: null, // Makes it an indeterminate progress indicator
                backgroundColor: Color.fromARGB(77, 208, 193, 255),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD0C1FF)),
                minHeight: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}