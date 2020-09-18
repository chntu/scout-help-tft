import 'package:flutter/material.dart';

import '../brain/match_making.dart';
import '../brain/player.dart';
import '../constants.dart';
import '../supportWidgets/boxbox.dart';

class Scout extends StatefulWidget {
  final List<Player> allPlayer1;
  Scout(this.allPlayer1);

  @override
  _ScoutState createState() => _ScoutState();
}

class _ScoutState extends State<Scout> {
  MatchMaking matchMaking = new MatchMaking();
  List<Player> allPlayer;
  bool clickEliminate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // make shallow copy of player List retrieve from homepage.
    allPlayer = widget.allPlayer1;
  }

  // Method to build one box taking player Number as parameter.
  BoxBox buildBox(int playerNum) {
    return BoxBox(
      allPlayer: allPlayer,
      clickEliminate: clickEliminate,
      matchMaking: matchMaking,
      playerNumber: playerNum,
      offEliminate: () {
        setState(() {
          matchMaking.updatePool(allPlayer[playerNum]);
        });
      },
      onEliminate: () {
        setState(() {
          matchMaking.removeDead(allPlayer[playerNum]);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 3.5;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: kAppbarColor,
          title: Center(
            child: Text('Scout Help'),
          ),
        ),
        backgroundColor: kBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Match making history'),

            SizedBox(
              height: kPaddingBetweenElem * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildBox(7),
                buildBox(0),
                buildBox(1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildBox(6),
                Container(
                  height: width,
                  width: width,
                  color: Colors.transparent,
                  margin: EdgeInsets.all(kBoxMargin),
                  constraints: BoxConstraints(maxWidth: 200, maxHeight: 200),
                ),
                buildBox(2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildBox(5),
                buildBox(4),
                buildBox(3),
              ],
            ),
            //Buttons : eliminate and Reset
            Padding(
              padding: const EdgeInsets.all(kPaddingBetweenElem),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      color: clickEliminate ? Colors.red : kAppbarColor,
                      child: clickEliminate
                          ? Text(
                              'Eliminate on',
                              style: kButtonTextStyle,
                            )
                          : Text(
                              'Eliminate off',
                              style: kButtonTextStyle,
                            ),
                      onPressed: () {
                        setState(() {
                          clickEliminate = !clickEliminate;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: kPaddingBetweenElem,
                  ),
                  Expanded(
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      color: kAppbarColor,
                      child: Text(
                        'Reset',
                        style: kButtonTextStyle,
                      ),
                      onPressed: () {
                        setState(() {
                          matchMaking.resetQ();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            //Buttons : Undo Eliminate and Undo Matches
            Padding(
              padding: const EdgeInsets.only(
                  bottom: kPaddingBetweenElem,
                  left: kPaddingBetweenElem,
                  right: kPaddingBetweenElem),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      color: kAppbarColor,
                      child: Text(
                        'Undo Eliminate',
                        style: kButtonTextStyle,
                      ),
                      onPressed: () {
                        setState(() {
                          matchMaking.undoEliminate();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: kPaddingBetweenElem,
                  ),
                  Expanded(
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      color: kAppbarColor,
                      child: Text(
                        'Undo Matches',
                        style: kButtonTextStyle,
                      ),
                      onPressed: () {
                        setState(() {
                          matchMaking.undoMatches();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
