import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe/constants.dart';
import 'package:tic_tac_toe/enums/game_state.dart';
import 'package:tic_tac_toe/models/player_model.dart';

class GameController extends ChangeNotifier {
  List<String> boards;
  List<PlayerModel> players;
  bool isTurn;
  GameState state;
  List<Color> colors;

  GameController({
    required this.boards,
    required this.players,
    this.isTurn = true,
    this.state = GameState.none,
    required this.colors,
  });

  make(BuildContext context, AnimationController animationController,
      int index) async {
    if (boards[index].isEmpty) {
      if (isTurn) {
        HapticFeedback.selectionClick();
        boards[index] = 'X';
        colors[index] = players[0].color;
        checkWinner(context, boards[index]);
      } else {
        HapticFeedback.selectionClick();
        boards[index] = 'O';
        colors[index] = players[1].color;
        checkWinner(context, boards[index]);
      }
      animationController.forward(from: 0);
      isTurn = !isTurn;
      notifyListeners();
      if (checkPositionsEmpty() == 9 && state == GameState.none) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.black,
            duration: Duration(seconds: 1),
            content: Text(
              'EMPATE',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'OpenSans',
                  color: Colors.yellowAccent),
            ),
          ),
        );
        await Future.delayed(const Duration(seconds: 2));
        restart();
      }
      if (state == GameState.finished) {
        await Future.delayed(const Duration(seconds: 2));
        restart();
      }
    }
  }

  setNamePlayer(int index, String name) {
    players[index].name = name;
    notifyListeners();
  }

  reset() {
    players[0].score = 0;
    players[1].score = 0;
    restart();
  }

  restart() {
    isTurn = true;
    state = GameState.none;
    boards = newBoards();
    colors = newColors();
    notifyListeners();
  }

  int checkPositionsEmpty() {
    int notEmpty = 0;
    for (var i = 0; i < boards.length; i++) {
      if (boards[i].isNotEmpty) {
        notEmpty += 1;
      }
    }
    return notEmpty;
  }

  checkWinner(BuildContext context, String value) {
    if (boards[0].contains(value) &&
            boards[1].contains(value) &&
            boards[2].contains(value) ||
        boards[3].contains(value) &&
            boards[4].contains(value) &&
            boards[5].contains(value) ||
        boards[6].contains(value) &&
            boards[7].contains(value) &&
            boards[8].contains(value) ||
        boards[0].contains(value) &&
            boards[3].contains(value) &&
            boards[6].contains(value) ||
        boards[1].contains(value) &&
            boards[4].contains(value) &&
            boards[7].contains(value) ||
        boards[2].contains(value) &&
            boards[5].contains(value) &&
            boards[8].contains(value) ||
        boards[0].contains(value) &&
            boards[4].contains(value) &&
            boards[8].contains(value) ||
        boards[2].contains(value) &&
            boards[4].contains(value) &&
            boards[6].contains(value)) {
      state = GameState.finished;
      players[isTurn ? 0 : 1].score += 1;
      showAdaptiveDialog(
        barrierDismissible: true,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 8),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Constants.victory,
                    style: const TextStyle(
                        fontSize: 48,
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'OpenSans'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    players[!isTurn ? 0 : 1].name,
                    style: TextStyle(
                        fontSize: 48,
                        color: players[!isTurn ? 0 : 1].color,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'OpenSans'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Sua pontuação é : ${players[!isTurn ? 0 : 1].score}',
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'OpenSans'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  static List<String> newBoards() => List.filled(Constants.sizeBoard, '');

  static List<Color> newColors() =>
      List.filled(Constants.sizeBoard, Colors.grey.shade900);

  static List<PlayerModel> newPlayers() => [
        PlayerModel(name: 'PLAYER X', score: 0, color: Colors.blue.shade900),
        PlayerModel(name: 'PLAYER O', score: 0, color: Colors.green.shade900),
      ];
}
