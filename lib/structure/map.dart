import 'package:chess_former/structure/position.dart';

class Level {
  // initial player position
  Position playerPosition = Position(x: 1, y: 1);
  // constructor
  Level({required this.playerPosition});
  // level two map
  List<List<String>> level2 = [
    ['cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell'],
    ['cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell'],
    ['wall','wall','wall','wall','wall','wall','wall','wall','wall','wall','wall','wall','cell','wall','wall','wall'],
    ['cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','wall','cell','wall','cell','cell'],
    ['cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell'],
    ['wall','wall','cell','wall','wall','wall','wall','wall','wall','wall','wall','wall','wall','wall','wall','wall'],
    ['cell','wall','cell','wall','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell'],
    ['cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell','cell'],
    ['wall','wall','wall','wall','wall','wall','wall','wall','wall','cell','wall','wall','wall','wall','wall','wall'],
    ['wall','wall','wall','wall','wall','wall','wall','wall','wall','goal','wall','wall','wall','wall','wall','wall'],
    ['wall','wall','wall','wall','wall','wall','wall','wall','wall','wall','wall','wall','wall','wall','wall','wall'],
  ];

  // compare by value
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Level &&
          runtimeType == other.runtimeType &&
          playerPosition == other.playerPosition;

  @override
  int get hashCode => playerPosition.hashCode;

  // deep copy method
  Level copyWith({required Position playerPosition}){
    return Level(playerPosition: playerPosition);
  }

}
