import 'package:facecheck_tft/brain/network.dart';
import 'package:facecheck_tft/brain/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constants.dart';
import '../supportWidgets/lable_checked_box.dart';
import 'scout_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This variable is for type name manually checked box.
  bool isManualChecked = true;
  // This variable is for insert Text from Riot checked box.
  bool isInsertChecked = false;
  // network to convert users input to allPlayerList
  Network network = new Network();

  // Controllers to retrieve text from your number box and insert json box.
  final yourNumberController = TextEditingController();
  final jsonBoxController = TextEditingController();

  // This controller to retrieve string from users manually input.
  // 8 boxes in total.
  List<TextEditingController> controllerList =
      new List<TextEditingController>(8);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // when this page start, create 8 controllers and put it in controllerList
    for (int i = 0; i < 8; i++) {
      final controller = TextEditingController();
      controllerList[i] = controller;
    }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    jsonBoxController.dispose();
    yourNumberController.dispose();
    for (int i = 0; i < 8; i++) {
      if (controllerList[i] != null) {
        controllerList[i].dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppbarColor,
        title: Text('Neeko Help'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kPaddingBetweenElem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //build user input boxes depend on isManualChecked or isInsertChecked.
              buildUserInput(),
              Wrap(
                spacing: kPaddingBetweenElem,
                children: [
                  // Checked box for user who want to type manually
                  LabeledCheckbox(
                    label: 'Type name manually',
                    value: isManualChecked,
                    onChanged: (bool newValue) {
                      setState(() {
                        isManualChecked = newValue;
                        isInsertChecked = !newValue;
                      });
                    },
                  ),
                  // Checked box for user who want to insert Riot Link
                  LabeledCheckbox(
                    label: 'Insert text from Riot link',
                    value: isInsertChecked,
                    onChanged: (bool newValue) {
                      setState(() {
                        isInsertChecked = newValue;
                        isManualChecked = !newValue;
                      });
                    },
                  ),
                ],
              ),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // This button send user to scout page when they successfully fill all info needed.
                  Expanded(
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      color: kAppbarColor,
                      child: Text(
                        'Scout Help',
                        style: kButtonTextStyle,
                      ),
                      onPressed: () {
                        if (isManualChecked) {
                          List<Player> playerList = new List(8);
                          for (int i = 0; i < 8; i++) {
                            Player player = new Player();
                            if (controllerList[i].text == '') {
                              player.isAlive = false;
                            }
                            player.playerName = controllerList[i].text;
                            playerList[i] = player;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Scout(playerList)),
                          );
                        } else {
                          if (jsonBoxController.text != '' &&
                              yourNumberController.text != '') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scout(
                                      network.getPlayerListJson(
                                          jsonBoxController.text,
                                          yourNumberController.text))),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: kPaddingBetweenElem,
                  ),
                  // This button send user to all players match history page.
                  // Expanded(
                  //   child: FlatButton(
                  //     padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  //     color: kAppbarColor,
                  //     child: Text(
                  //       'FaceCheck',
                  //       style: kButtonTextStyle,
                  //     ),
                  //     onPressed: () {},
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // build user input depends on isManualChecked or isInsertChecked.
  Widget buildUserInput() {
    if (isManualChecked) {
      return buildManualBoxes();
    } else {
      return buildInsertRiot();
    }
  }

  // build 8 manually input boxes
  Widget buildManualBoxes() {
    return Column(
      children: [
        Row(
          children: [
            buildManualInputBox(1),
            buildManualInputBox(2),
            buildManualInputBox(3),
            buildManualInputBox(4),
          ],
        ),
        Row(
          children: [
            buildManualInputBox(5),
            buildManualInputBox(6),
            buildManualInputBox(7),
            buildManualInputBox(8),
          ],
        ),
      ],
    );
  }

  // build 2 boxes, one for user number, another for riot json string.
  Widget buildInsertRiot() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: TextField(
            controller: yourNumberController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Your Number',
              labelStyle: TextStyle(
                fontSize: kFontSize,
              ),
            ),
          ),
        ),
        Container(
          height: 150,
          constraints: BoxConstraints(maxHeight: 150),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            border: Border.all(width: 1.0, color: Colors.black26),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: TextField(
              controller: jsonBoxController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Insert Text From Riot Link here',
                hintStyle: TextStyle(
                  fontSize: kFontSize,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // This method to build 1 box take in player Number.
  Widget buildManualInputBox(int playerNum) {
    double width = MediaQuery.of(context).size.width;
    return Flexible(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          controller: controllerList[playerNum - 1],
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Player$playerNum',
            labelStyle: TextStyle(
              // for small screen width smaller then 550 reduce font size of hint text.
              fontSize: width < 550 ? width / 31 : kFontSize,
            ),
          ),
        ),
      ),
    );
  }
}
