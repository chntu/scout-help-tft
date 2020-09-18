import 'dart:convert';

import 'package:http/http.dart' as http;

import 'player.dart';

class Network {
  // Return list of players' name from api url.
  Future<List<Player>> getPlayerListAPI() async {
    List<Player> playerList = new List();
    var url = 'http://www.json-generator.com/api/json/get/cedEXBPUte?indent=2';
    http.Response response = await http.get(url);

    var playerData = await jsonDecode(response.body);

    for (int i = 0; i < 8; i++) {
      Player player =
          Player(playerName: await playerData['allPlayers'][i]['summonerName']);
      playerList.add(player);
    }

    return playerList;
  }

  // Return list of players' name from user json string input.
  List<Player> getPlayerListJson(String jsonString, String yourNumber) {
    List<Player> playerList = new List(8);

    int yourNumberInt = int.parse(yourNumber) - 1;
    Player userPlayer = Player(playerName: '');
    userPlayer.isAlive = false;
    playerList[yourNumberInt] = userPlayer;

    var playerData = jsonDecode(jsonString);
    int whereToAdd = 0;
    for (int i = 1; i < 8; i++) {
      String playerName = playerData['allPlayers'][i]['summonerName'];
      Player player = Player(playerName: playerName);

      if (whereToAdd == yourNumberInt) {
        whereToAdd++;
        playerList[whereToAdd] = player;
      } else {
        playerList[whereToAdd] = player;
      }
      whereToAdd++;
    }
    return playerList;
  }
}
