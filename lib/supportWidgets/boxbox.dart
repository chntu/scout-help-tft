import 'package:flutter/material.dart';

import '../brain/match_making.dart';
import '../brain/player.dart';
import '../constants.dart';

class BoxBox extends StatelessWidget {
  const BoxBox(
      {@required this.allPlayer,
      @required this.playerNumber,
      @required this.onEliminate,
      @required this.clickEliminate,
      @required this.offEliminate,
      @required this.matchMaking});

  final List<Player> allPlayer;
  final int playerNumber;
  final Function onEliminate;
  final Function offEliminate;
  final bool clickEliminate;
  final MatchMaking matchMaking;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 3.5;
    Function eliminateOff;
    Function eliminateOn;
    Player player = allPlayer[playerNumber];
    if (player.isAlive & player.isNextRound) {
      eliminateOff = offEliminate;
    } else {
      eliminateOff = null;
    }
    if (player.isAlive) {
      eliminateOn = onEliminate;
    } else {
      eliminateOn = null;
    }
    return GestureDetector(
      onTap: clickEliminate ? eliminateOn : eliminateOff,
      child: Container(
        height: width,
        width: width,
        decoration: BoxDecoration(
          color: player.getColor(),
          border: Border.all(color: kBoxBorderColor, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        constraints: BoxConstraints(maxWidth: 200, maxHeight: 200),
        margin: EdgeInsets.all(kBoxMargin),
        child: Center(
          child: Text(
            player.playerName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
