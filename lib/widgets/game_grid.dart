import 'package:flip_card/models/memory_card_model.dart';
import 'package:flip_card/widgets/game_card.dart';
import 'package:flutter/material.dart';

class GameGrid extends StatelessWidget {
  final List<MemoryCardModel> cards; 
  final Function(MemoryCardModel) onCardTap;
  const GameGrid({super.key, required this.cards, required this.onCardTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: cards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        final card = cards[index];
        return GameCard(card: card, onTap: () => onCardTap(card));
      },
    );
  }
}