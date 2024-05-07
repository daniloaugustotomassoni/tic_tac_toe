import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/constants.dart';
import 'package:tic_tac_toe/controllers/game_controller.dart';

class PlayersWidget extends StatefulWidget {
  const PlayersWidget({super.key});

  @override
  State<PlayersWidget> createState() => _PlayersWidgetState();
}

class _PlayersWidgetState extends State<PlayersWidget> {
  TextEditingController playerX = TextEditingController();
  TextEditingController playerO = TextEditingController();

  @override
  Widget build(BuildContext context) {
    edit(int index, GameController game, TextEditingController controller) {
      controller.text = game.players[index].name;
      showAdaptiveDialog(
        barrierDismissible: true,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: TextField(
                    controller: controller,
                    maxLength: 8,
                    maxLines: 1,
                    autofocus: true,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      label: Text(
                        Constants.messageTextField,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: OutlinedButton(
                    onPressed: () {
                      if (controller.value.text.isNotEmpty) {
                        game.setNamePlayer(
                            index, controller.value.text.toUpperCase());
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      Constants.btnConfirm,
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'OpenSans'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Consumer<GameController>(
      builder: (context, game, child) {
        return AppBar(
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * .2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: GestureDetector(
                      onTap: () => edit(0, game, playerX),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * .2,
                        child: Column(
                          children: [
                            Text(
                              game.players[0].score.toString(),
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'OpenSans'),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: game.players[0].color,
                                  child: const Icon(Icons.person),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  game.players[0].name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => edit(1, game, playerO),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * .2,
                      child: Column(
                        children: [
                          Text(
                            game.players[1].score.toString(),
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'OpenSans'),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: game.players[1].color,
                                child: const Icon(Icons.perm_identity_sharp),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                game.players[1].name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
