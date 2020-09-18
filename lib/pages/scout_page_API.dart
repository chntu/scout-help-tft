// import 'package:flutter/material.dart';
//
// import '../brain/match_making.dart';
// import '../brain/network.dart';
// import '../brain/player.dart';
// import '../constants.dart';
// import '../supportWidgets/boxbox.dart';
//
// class Scouting extends StatefulWidget {
//   @override
//   _ScoutingState createState() => _ScoutingState();
// }
//
// class _ScoutingState extends State<Scouting> {
//   Network network = new Network();
//   Future<List<Player>> fetchAllPlayer;
//   MatchMaking matchMaking = new MatchMaking();
//   List<Player> allPlayer;
//   bool clickEliminate = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchAllPlayer = network.getPlayerListAPI();
//   }
//
//   BoxBox buildBox(int playerNum) {
//     return BoxBox(
//       allPlayer: allPlayer,
//       clickEliminate: clickEliminate,
//       matchMaking: matchMaking,
//       playerNumber: playerNum,
//       offEliminate: () {
//         setState(() {
//           matchMaking.updatePool(allPlayer[playerNum]);
//         });
//       },
//       onEliminate: () {
//         setState(() {
//           matchMaking.removeDead(allPlayer[playerNum]);
//         });
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width / 3.5;
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: kAppbarColor,
//           title: Center(
//             child: Text('Scout Help'),
//           ),
//         ),
//         backgroundColor: kBackgroundColor,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: FutureBuilder(
//                   future: fetchAllPlayer,
//                   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                     if (snapshot.data == null) {
//                       return Container(
//                         height: width,
//                         width: width,
//                         color: Colors.red,
//                         margin: EdgeInsets.all(kBoxMargin),
//                       );
//                     } else {
//                       allPlayer = snapshot.data;
//                       return Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               buildBox(7),
//                               buildBox(0),
//                               buildBox(1),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               buildBox(6),
//                               Container(
//                                 height: width,
//                                 width: width,
//                                 color: Colors.transparent,
//                                 margin: EdgeInsets.all(kBoxMargin),
//                                 constraints: BoxConstraints(
//                                     maxWidth: 200, maxHeight: 200),
//                               ),
//                               buildBox(2),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               buildBox(5),
//                               buildBox(4),
//                               buildBox(3),
//                             ],
//                           ),
//                         ],
//                       );
//                     }
//                   }),
//             ),
//             FlatButton(
//               color: clickEliminate ? Colors.red : Colors.white,
//               child:
//                   clickEliminate ? Text('Eliminate on') : Text('Eliminate off'),
//               onPressed: () {
//                 setState(() {
//                   clickEliminate = !clickEliminate;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
