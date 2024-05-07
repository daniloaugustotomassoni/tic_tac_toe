import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/controllers/game_controller.dart';

import 'board_item_widget.dart';

class BoardWidget extends StatefulWidget {
  const BoardWidget({super.key});

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (_, game, child) => Expanded(
        child: Container(
          padding: EdgeInsets.zero,
          child: GridView.builder(
              itemCount: game.boards.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
              ),
              itemBuilder: (_, index) {
                return BoardItemWidget(
                  index: index,
                  game: game,
                );
              }),
        ),
      ),
    );
  }
}
