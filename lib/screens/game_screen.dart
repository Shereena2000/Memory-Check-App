import 'package:flip_card/providers/memory_game_provider.dart';
import 'package:flip_card/screens/success_screen.dart';
import 'package:flip_card/utils/constants.dart';
import 'package:flip_card/widgets/game_app_bar.dart';
import 'package:flip_card/widgets/game_grid.dart';
import 'package:flip_card/widgets/game_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: GameAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<MemoryGameProvider>(
            builder: (context, provider, child) {
              if (provider.isGameComplete) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuccessScreen()),
                  );
                });
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GameInfo(
                   
                      moves: provider.moves,
                      formattedTime: provider.formattedTime,
                    ),
                  ),

                  Spacer(),

                  GameGrid(
                    cards: provider.cards,
                    onCardTap: (card) => provider.flipCard(card),
                  ),
                  kheight20,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
