import 'package:flip_card/utils/colors_constand.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const CustomIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 36,
      child: AnimatedContainer(
         duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          border: Border.all(
            color: whiteColor, // Use your whiteColor
            width: 1.0, // Border thickness
          ),
          borderRadius: BorderRadius.circular(8.0), // Optional rounded corners
        ),
        child: Center(
          child: IconButton(
            icon: Icon(icon, size: 20),
            color: whiteColor,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
