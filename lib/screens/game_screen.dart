import 'package:flip_card/models/memory_card_model.dart';
import 'package:flip_card/providers/memory_game_provider.dart';
import 'package:flip_card/utils/colors_constand.dart';
import 'package:flip_card/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<MemoryGameProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kheight20,
                        Text(
                          "0 moves",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          "00:00.00",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        kheight20,
                      ],
                    ),
                  ),

                  // Card Grid
                  Expanded(
                    child: GridView.builder(
                      itemCount: provider.cards.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                          ),
                      itemBuilder: (context, index) {
                        final card=provider.cards[index];
                        return GameCard(card: card,onTap:()=>provider.flipCard(card) ,);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
    final MemoryCardModel card;
      final VoidCallback onTap;
  const GameCard({
    super.key,required this.card, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color:card.isFlipped || card.isMatched? yellowColor:lightPurpleColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: card.isFlipped || card.isMatched
            ? Text(
                card.content, 
                style: TextStyle(fontSize: 40)
              )
            : Text("")
        ),
      ),
    );
  }
}
