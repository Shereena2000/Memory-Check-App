class MemoryCardModel {
  final String id;
  final String content;
  bool isFlipped;
  bool isMatched;
  MemoryCardModel({
    required this.id,
    required this.content,
    this.isFlipped = false,
    this.isMatched = false,
  }); MemoryCardModel copyWith({
    bool? isFlipped,
    bool? isMatched,
  }) {
    return MemoryCardModel(
      id: id,
      content: content,
      isFlipped: isFlipped ?? this.isFlipped,
      isMatched: isMatched ?? this.isMatched,
    );
  }
}
