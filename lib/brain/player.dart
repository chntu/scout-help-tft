import 'package:facecheck_tft/constants.dart';
import 'package:flutter/material.dart';

//
class Player {
  Player({this.playerName});

  String playerName;
  bool isNextRound = true;
  bool isAlive = true;

  // Return color of player for boxbox
  Color getColor() {
    Color boxColor;
    if (isAlive) {
      if (isNextRound == false) {
        boxColor = kBoxColorPlayed;
      } else {
        boxColor = kBoxColorAlive;
      }
    } else {
      boxColor = kBoxColorDead;
    }

    return boxColor;
  }
}
