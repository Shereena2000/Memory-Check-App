import 'package:flip_card/models/memory_card_model.dart';
import 'package:flip_card/utils/colors_constand.dart';
import 'package:flutter/material.dart';

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
