import 'package:flip_card/utils/constants.dart';
import 'package:flutter/material.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "FLIP\nCARDS",
   
      style: logoTextStyle,
    );
  }
}