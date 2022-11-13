import 'package:chess_former/structure/map.dart';
import 'package:chess_former/structure/position.dart';
import 'package:flutter/material.dart';

class Move extends ChangeNotifier {
  // for animation purposes
  // player position on the screen is 70 pixels from the top
  double top = 70;
  // and 70 pixels from left
  double left = 70;
  // animation duration
  int duration = 100;
  // creating an instance from our Level class
  Level level = Level(playerPosition: Position(x: 1, y: 1));
  // player position(x,y)
  Position? playerPosition;
  // boolean list of available moves for the ui part
  List<List<bool>> availableMoves =
      List.generate(11, (x) => List.generate(16, (y) => false));
  // List of Positions for the logical part
  List<Position> availablePosition = [];

  // clear the previous two lists
  void clearAvailableMoves() {
    availableMoves = List.generate(11, (x) => List.generate(16, (y) => false));
    availablePosition = [];
  }

  // get the player position
  Position getPlayerPosition() {
    Position position = level.playerPosition;
    return position;
  }

  // check the available places to move to it
  void checkMove() {
    Position currentPosition = getPlayerPosition();
    List<List<String>> map = level.level2;
    clearAvailableMoves();

    // check right
    for (int i = currentPosition.y+1; i < 16; i++) {
      if (map[currentPosition.x][i] == 'wall') {
        break;
      } else {
        availableMoves[currentPosition.x][i] = true;
        availablePosition.add(Position(x: currentPosition.x, y: i));
      }
    }

    //check left
    for (int i = currentPosition.y-1; i >= 0; i--) {
      if (map[currentPosition.x][i] == 'wall') {
        break;
      } else {
        availableMoves[currentPosition.x][i] = true;
        availablePosition.add(Position(x: currentPosition.x, y: i));
      }
    }

    // check up
    for (int i = currentPosition.x - 1; i >= 0; i--) {
      if (map[i][currentPosition.y] == 'wall') {
        break;
      } else {
        availableMoves[i][currentPosition.y] = true;
        availablePosition.add(Position(x: i, y: currentPosition.y));
      }
    }
    notifyListeners();
  }

  //move player to position(x,y)
  Future<void> movePlayer(Position targetPosition, BuildContext context) async {
    Position playerPosition = getPlayerPosition();
    if (playerPosition.y != targetPosition.y) {
      duration = ((targetPosition.y - playerPosition.y).abs() * 100);
    } else {
      duration = ((targetPosition.x - playerPosition.x).abs() * 100);
    }
    left = left + ((targetPosition.y - playerPosition.y) * 70);
    top = top + ((targetPosition.x - playerPosition.x) * 70);
    level.playerPosition = Position(x: targetPosition.x, y: targetPosition.y);
    clearAvailableMoves();
    Future.delayed(Duration(milliseconds: duration), () {
      checkGravity(targetPosition, context);
    });
    notifyListeners();
  }

  //check if there is a wall under the player or he will fall down
  void checkGravity(Position playerPosition, BuildContext context) {
    List<List<String>> map = level.level2;
    int finalPos = playerPosition.x;
    for (int i = playerPosition.x; i < 10; i++) {
      if (map[i + 1][playerPosition.y] == 'wall') {
        finalPos = i;
        break;
      }
    }
    // level[playerPosition.x][playerPosition.y] = 'cell';
    // level[finalPos!][playerPosition.y] = 'rook';
    level.playerPosition = Position(x: finalPos, y: playerPosition.y);
    duration = ((finalPos - playerPosition.x).abs() * 100);
    top = top + ((finalPos - playerPosition.x) * 70);
    Future.delayed(Duration(milliseconds: duration), () {
      if (checkWin()) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SizedBox(
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/win.png',
                          height: 100,
                        ),
                        const Text(
                          'Winner',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      } else {
        checkMove();
      }
    });
    notifyListeners();
  }

  // get the position of the goal
  Position getTargetPosition() {
    List<List<String>> map = level.level2;
    Position position = Position(x: -1, y: -1);
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 16; j++) {
        if (map[i][j] == 'goal') {
          position = Position(x: i, y: j);
          return position;
        }
      }
    }
    return position;
  }

  // check the win state
  bool checkWin() {
    Position targetPosition = getTargetPosition();
    Position playerPosition = getPlayerPosition();
    if (playerPosition == targetPosition) {
      return true;
    } else {
      return false;
    }
  }

  // to compare by values
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Move &&
          runtimeType == other.runtimeType &&
          top == other.top &&
          left == other.left &&
          duration == other.duration &&
          playerPosition == other.playerPosition &&
          availableMoves == other.availableMoves;

  @override
  int get hashCode =>
      top.hashCode ^
      left.hashCode ^
      duration.hashCode ^
      playerPosition.hashCode ^
      availableMoves.hashCode;

  // get next state method
  List<Level> getNextState() {
    List<Level> nextState = <Level>[];
    List<Position> positions = availablePosition;
    for (Position position in positions) {
      Level l = Level(playerPosition: level.playerPosition)
          .copyWith(playerPosition: position);
      nextState.add(l);
    }
    return nextState;
  }
}
