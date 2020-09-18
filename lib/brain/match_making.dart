import 'dart:collection';

import 'player.dart';

/// This class handle the game matchmaking algorithm to predict next opponent
///
/// Implement matchmaking algorithm:
/// With 7 other players alive, you will not revisit the last 4 you have faced.
/// With 6 others alive, the last 3.
/// With 5 others alive, the last 2.
/// With 2,3 or 4 others alive, you will not visit the last player you faced.
class MatchMaking {
  Queue<Player> notPlayNextRound = new Queue();
  int alivePlayerCount = 7;
  List<Player> eliminateList = new List<Player>();
  List<Player> playedList = new List<Player>();
  List<Player> freeList = new List<Player>();
  int qMax;
  void updateQMax() {
    if (alivePlayerCount >= 7) {
      qMax = 4;
    } else if (alivePlayerCount == 6) {
      qMax = 3;
    } else if (alivePlayerCount == 5) {
      qMax = 2;
    } else if (alivePlayerCount == 4 ||
        alivePlayerCount == 3 ||
        alivePlayerCount == 2) {
      qMax = 1;
    }
  }

  /// This method is called when user clicks a box.
  /// Parameter is a player who played against last round.
  void updatePool(Player player) {
    // qMax is variable to limit notPlayNextRound length depends on current alive players.
    updateQMax();
    // when the q reach maximum qMax, remove the first one in Q back to pool
    if (notPlayNextRound.length == qMax) {
      Player playerToPool = notPlayNextRound.removeFirst();
      playerToPool.isNextRound = true;
      freeList.add(playerToPool);
    }
    notPlayNextRound.add(player);
    player.isNextRound = false;
    playedList.add(player);
  }

  // This method is called when user double clicks a box indicating someone is dead.
  // Q resets
  void removeDead(Player player) {
    player.isAlive = false;
    alivePlayerCount--;
    eliminateList.add(player);
    resetQ();
  }

  // reset notPlayNextRound q
  void resetQ() {
    while (notPlayNextRound.length > 0) {
      notPlayNextRound.removeFirst().isNextRound = true;
    }
  }

  // Undo matches when user clicks undo matches button on scout page.
  void undoMatches() {
    if (notPlayNextRound.length > 0) {
      Player playerToRemove = notPlayNextRound.removeLast();
      playerToRemove.isNextRound = true;
    }
    if (freeList.length > 0) {
      Player playerToAdd = freeList.removeLast();
      playerToAdd.isNextRound = false;
      notPlayNextRound.addFirst(playerToAdd);
    }
  }

  // Undo Elimination when user clicks undo Eliminate on scout page.
  void undoEliminate() {
    if (eliminateList.length > 0) {
      Player playerToUnEliminate = eliminateList.removeLast();
      playerToUnEliminate.isAlive = true;
      alivePlayerCount++;
      resetQ();
      updateQMax();
      for (int i = playedList.length - 1; i > 0; i--) {
        Player player = playedList[i];
        if (notPlayNextRound.length == qMax) {
          break;
        } else {
          notPlayNextRound.addLast(player);
          player.isNextRound = false;
        }
      }
    }
  }
}
