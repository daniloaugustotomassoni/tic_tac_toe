import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_toe/controllers/game_controller.dart';

import '../enums/game_state.dart';

class BoardItemWidget extends StatefulWidget {
  final int index;
  final GameController game;

  const BoardItemWidget({super.key, required this.index, required this.game});

  @override
  State<BoardItemWidget> createState() => _BoardItemWidgetState();
}

class _BoardItemWidgetState extends State<BoardItemWidget>
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
    return GestureDetector(
        onTap: widget.game.state == GameState.none
            ? () {
                widget.game.make(context, animationController, widget.index);
              }
            : () {},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: widget.game.colors[widget.index],
              borderRadius: const BorderRadius.all(Radius.circular(0))),
          child: Text(
            widget.game.boards[widget.index],
            style: const TextStyle(
              fontSize: 96,
              fontWeight: FontWeight.w900,
              fontFamily: 'OpenSans',
            ),
          ).animate(controller: animationController).fade().flip(),
        ));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
