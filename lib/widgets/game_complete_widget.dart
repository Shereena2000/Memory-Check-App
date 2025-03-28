import 'package:flip_card/providers/memory_game_provider.dart';
import 'package:flip_card/utils/colors_constand.dart';
import 'package:flip_card/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameCompletedWidget extends StatelessWidget {
  const GameCompletedWidget({super.key});
  @override
  Widget build(BuildContext context) {double  screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(25),
      width: double.infinity,
      height: screenHeight * 0.5,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: yellowColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: yellowColor.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative elements
          Positioned(
            top: 10,
            right: 10,
            child: Text("🎯", style: TextStyle(fontSize: 40)),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text("🏆", style: TextStyle(fontSize: 40)),
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("🔥", style: TextStyle(fontSize: 60)),
              const SizedBox(height: 10),
              Text(
                "VICTORY!",
                style: largeText.copyWith(
                  fontSize: 36,
                  color: yellowColor,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: yellowColor.withOpacity(0.5),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                "You crushed it!",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<MemoryGameProvider>(context, listen: false).resetGame();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowColor,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 20,
                    ),
                    elevation: 5,
                    shadowColor: yellowColor.withOpacity(0.5),
                  ),
                  child: Text(
                    "NEW GAME",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}