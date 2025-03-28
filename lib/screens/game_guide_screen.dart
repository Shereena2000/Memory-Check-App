import 'package:flip_card/screens/game_screen.dart';
import 'package:flip_card/utils/colors_constand.dart';
import 'package:flip_card/widgets/appbar_logo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameGuideScreen extends StatelessWidget {
  const GameGuideScreen({super.key});

  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_launch') ?? true;
  }

  // Helper method to set first launch to false
  static Future<void> setFirstLaunchComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_launch', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppBarLogo()),
      body: AlertDialog(
        backgroundColor: yellowColor,
        title: Text(
          'How to Play',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Text(
            'Welcome to the Memory Card Game! Your goal is to match all the pairs of cards. Start by turning over any two picture cards. If the cards match, you keep them face up. If they don\'t match, carefully turn them back over. The key to winning is to remember the location and content of each card you\'ve seen. Pay close attention and use your memory skills to find matching pairs. The game continues until all cards are successfully matched. Good luck and have fun!',
            style: TextStyle(color: Colors.black, fontSize: 16, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed:
                  ()async {
                await setFirstLaunchComplete(); // Mark first launch as complete
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => GameScreen())
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: blackColor,
                foregroundColor: Colors.white,
              ),
              child: Text('Let\'s Play!'),
            ),
          ),
        ],
      ),
    );
  }
}
