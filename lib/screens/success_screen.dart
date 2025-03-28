import 'package:flip_card/providers/memory_game_provider.dart';
import 'package:flip_card/widgets/appbar_logo.dart';
import 'package:flip_card/widgets/game_complete_widget.dart';
import 'package:flip_card/widgets/score_board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size and orientation
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final orientation = mediaQuery.orientation;

    // Adjust padding and sizing based on screen size
    double horizontalPadding = screenWidth * 0.05;
    double verticalPadding = screenHeight * 0.02;

    return Scaffold(
      appBar: AppBar(
        title: const AppBarLogo(),
      automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight - AppBar().preferredSize.height - mediaQuery.padding.top,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Score Board
                  Consumer<MemoryGameProvider>(
                    builder: (context, provider, child) {
                      return ScoreBoard(
                        isGameComplete: provider.isGameComplete,
                        moves: provider.moves,
                        formattedTime: provider.formattedTime,
                        bestTime: provider.bestTime,
                      );
                    },
                  ),

                  // Add some vertical spacing
                  SizedBox(height: screenHeight * 0.02),

                  // Game Completed Widget
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        height: orientation == Orientation.portrait 
                          ? screenHeight * 0.5 
                          : screenHeight * 0.6,
                        child: const GameCompletedWidget(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}