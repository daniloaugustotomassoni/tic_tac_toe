import 'dart:ui';

class PlayerModel {
  String name;
  int score;
  Color color;

  PlayerModel({required this.name, required this.score, required this.color});

  PlayerModel getPlayer() => this;
}
