import 'dart:async';
import 'package:flip_card/models/memory_card_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoryGameProvider extends ChangeNotifier {
  final int gridSize;
  List<MemoryCardModel> cards = [];
  final List<String> cardContents;
  final List<MemoryCardModel> _flippedCards = [];
  bool _isChecking = false;
  bool isGameComplete = false;
  int moves = 0;
  Duration elapsedTime = Duration.zero;
  Timer? _timer;
  Duration? bestTime;
  int? bestMoves;

  MemoryGameProvider({this.gridSize = 36, List<String>? cardContents})
      : cardContents = cardContents ?? _defaultCardContents {
    initializeGame();
    _loadBestScore();
  }

  static final List<String> _defaultCardContents = [
    '🍎', '🍌', '🍇', '🍉', '🍊', '🍋', '🍍', '🥝',
  ];

  Future<void> _loadBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    final savedBestTimeInMillis = prefs.getInt('bestTimeMillis');
    final savedBestMoves = prefs.getInt('bestMoves');

    if (savedBestTimeInMillis != null) {
      bestTime = Duration(milliseconds: savedBestTimeInMillis);
    }
    if (savedBestMoves != null) {
      bestMoves = savedBestMoves;
    }
    notifyListeners();
  }

  Future<void> _saveBestScore() async {
    final prefs = await SharedPreferences.getInstance();

    // Update best time if current time is faster
    if (bestTime == null || elapsedTime < bestTime!) {
      await prefs.setInt('bestTimeMillis', elapsedTime.inMilliseconds);
      bestTime = elapsedTime;
    }

    // Update best moves if current moves are fewer
    if (bestMoves == null || moves < bestMoves!) {
      await prefs.setInt('bestMoves', moves);
      bestMoves = moves;
    }

    notifyListeners();
  }

  void initializeGame() {
    cards = [];
    for (var content in cardContents.take(gridSize ~/ 2)) {
      cards.add(MemoryCardModel(id: UniqueKey().toString(), content: content));
      cards.add(MemoryCardModel(id: UniqueKey().toString(), content: content));
    }
    cards.shuffle();
    moves = 0;
    elapsedTime = Duration.zero;
    isGameComplete = false;
    _flippedCards.clear();
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      elapsedTime += Duration(milliseconds: 100);
      notifyListeners();
    });
  }

  String get formattedTime {
    int totalTenths = elapsedTime.inMilliseconds ~/ 100;
    int tenths = totalTenths % 10;
    int totalSeconds = totalTenths ~/ 10;
    int seconds = totalSeconds % 60;
    int minutes = totalSeconds ~/ 60;

    return '${minutes.toString().padLeft(2, '0')}:'
           '${seconds.toString().padLeft(2, '0')}.'
           '$tenths';
  }

  void flipCard(MemoryCardModel card) {
    if (card.isMatched || _flippedCards.length >= 2 || _isChecking) return;
    final index = cards.indexWhere((c) => c.id == card.id);
    cards[index] = card.copyWith(isFlipped: true);
    _flippedCards.add(cards[index]);

    if (_flippedCards.length == 2) {
      moves++;
      _checkForMatch();
    }
    notifyListeners();
  }

  void _checkForMatch() {
    if (_flippedCards.length < 2) return;
    _isChecking = true;
    Future.delayed(Duration(seconds: 1), () {
      if (_flippedCards[0].content == _flippedCards[1].content) {
        cards = cards.map((card) {
          return _flippedCards.contains(card)
              ? card.copyWith(isMatched: true)
              : card;
        }).toList();
        isGameComplete = cards.every((card) => card.isMatched);
        if (isGameComplete) {
          _timer?.cancel();
          _saveBestScore(); // Save best score when game is complete
        }
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

  void resetGame() {
    _timer?.cancel();
    initializeGame();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}