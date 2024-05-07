import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/constants.dart';
import 'package:tic_tac_toe/controllers/game_controller.dart';

class RestartButtonWidget extends StatefulWidget {
  const RestartButtonWidget({super.key});

  @override
  State<RestartButtonWidget> createState() => _RestartButtonWidgetState();
}

class _RestartButtonWidgetState extends State<RestartButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (_, game, child) {
        return FloatingActionButton.large(
          backgroundColor: Colors.green.shade900,
          tooltip: Constants.restart,
          onPressed: () {
            animationController.reverse(from: 1);
            HapticFeedback.mediumImpact();
            game.restart();
          },
          child: const Icon(
            Icons.restart_alt_sharp,
            size: 48,
          ).animate(controller: animationController).rotate(),
        );
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
