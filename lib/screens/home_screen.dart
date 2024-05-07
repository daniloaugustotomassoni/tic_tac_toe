import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/controllers/game_controller.dart';
import 'package:tic_tac_toe/widgets/board_widget.dart';
import 'package:tic_tac_toe/widgets/players_widget.dart';

import '../widgets/restart_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
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
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * .2),
            child: const PlayersWidget(),
          ),
          body: Column(
            children: [
              const BoardWidget(),
              IconButton(
                tooltip: 'RESET',
                onPressed: () {
                  animationController.forward(from: 0);
                  HapticFeedback.vibrate();
                  game.reset();
                },
                icon: Icon(
                  Icons.delete_outline,
                  size: 48,
                  color: Colors.red.shade900,
                ).animate(controller: animationController).fade().shake(),
              ),
            ],
          ),
          floatingActionButton: const RestartButtonWidget(),
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
