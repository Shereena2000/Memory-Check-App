import 'package:flip_card/models/memory_card_model.dart';
import 'package:flutter/material.dart';

class MemoryGameProvider extends ChangeNotifier {
  final int gridSize;
  List<MemoryCardModel> cards = [];
  final List<String> cardContents;

  List<MemoryCardModel> _flippedCards = [];
  bool _isChecking = false;
  MemoryGameProvider({this.gridSize = 4, List<String>? cardContents})
    : cardContents = cardContents ?? _defaultCardContents {
    initializeGame();
  }

  static final List<String> _defaultCardContents = [
    '🍎',
    '🍌',
    '🍇',
    '🍉',
    '🍊',
    '🍋',
    '🍍',
    '🥝',
  ];
  void initializeGame() {
    cards = [];
    for (var content in cardContents.take(gridSize ~/ 2)) {
      cards.add(MemoryCardModel(id: UniqueKey().toString(), content: content));
      cards.add(MemoryCardModel(id: UniqueKey().toString(), content: content));
    }

    notifyListeners();
  }

  void flipCard(MemoryCardModel card) {
 if (card.isMatched || 
        _flippedCards.length >= 2 || 
        _isChecking ) return;
    final index = cards.indexWhere((c) => c.id == card.id);
    cards[index] = card.copyWith(isFlipped: true);
    _flippedCards.add(cards[index]);

    if (_flippedCards.length == 2) {
      _checkForMatch();
    }
    notifyListeners();
  }

  void _checkForMatch() {
    if (_flippedCards.length < 2) return;
     _isChecking = true; 
    Future.delayed(Duration(seconds: 1), () {
      if (_flippedCards[0].content == _flippedCards[1].content) {
        cards =
            cards.map((card) {
              return _flippedCards.contains(card)
                  ? card.copyWith(isMatched: true)
                  : card;
            }).toList();
      } else {
        cards = cards.map((card) {
          return _flippedCards.contains(card) 
            ? card.copyWith(isFlipped: false) 
            : card;
        }).toList();
      }
      _flippedCards.clear();
      _isChecking = false;
      notifyListeners();
    });
   
  }
}
