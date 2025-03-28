import 'package:flip_card/utils/constants.dart';
import 'package:flutter/material.dart';

class GameInfo extends StatelessWidget {
 
  final int moves;
  final String formattedTime;


  const GameInfo({
    super.key, 
    required this.moves, 
    required this.formattedTime, 
    
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     
        Text("$moves moves", style: Theme.of(context).textTheme.displaySmall),
        kheight5,
        Text(formattedTime, style: Theme.of(context).textTheme.displayMedium),
       
      ],
    );
  }

 
}