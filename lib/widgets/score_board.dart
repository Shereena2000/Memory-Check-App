
import 'package:flip_card/utils/colors_constand.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final bool isGameComplete;
  final int moves;
  final String formattedTime;
  final Duration? bestTime;

  const ScoreBoard({
    super.key, 
    required this.moves, 
    required this.formattedTime, 
    required this.isGameComplete,
    this.bestTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: blackColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: lightPurpleColor,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isGameComplete && bestTime != null)
            _buildStatTile(
              icon: Icons.emoji_events,
              label: 'Best Time',
              value: _formatDuration(bestTime!),
              isHighlighted: true,
            ),
          _buildStatTile(
            icon: Icons.timer,
            label: 'Your Time',
            value: formattedTime,
          ),
          _buildStatTile(
            icon: Icons.swap_horiz,
            label: 'Moves',
            value: '$moves',
          ),
        ],
      ),
    );
  }

  Widget _buildStatTile({
    required IconData icon,
    required String label,
    required String value,
    bool isHighlighted = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: isHighlighted ? Colors.yellow[600] : Colors.purpleAccent,
            size: 24,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  color: isHighlighted ? Colors.yellow[600] : Colors.white,
                  fontSize: isHighlighted ? 20 : 18,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    int totalTenths = duration.inMilliseconds ~/ 100;
    int tenths = totalTenths % 10;
    int totalSeconds = totalTenths ~/ 10;
    int seconds = totalSeconds % 60;
    int minutes = totalSeconds ~/ 60;

    return '${minutes.toString().padLeft(2, '0')}:'
           '${seconds.toString().padLeft(2, '0')}.'
           '$tenths';
  }
}