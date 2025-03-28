import 'package:flip_card/providers/memory_game_provider.dart';
import 'package:flip_card/utils/constants.dart';
import 'package:flip_card/widgets/appbar_logo.dart';
import 'package:flip_card/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GameAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppBarLogo(),
      actions: const [AppBarActions()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}



class AppBarActions extends StatelessWidget {
  const AppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          icon: Icons.restart_alt,
          onPressed: () => Provider.of<MemoryGameProvider>(context, listen: false).resetGame(),
        ),
        kwidth5,
      CustomIconButton(icon: Icons.volume_up_outlined, onPressed: (){}),
        kwidth20,
      ],
    );
  }
}