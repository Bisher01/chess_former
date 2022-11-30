import 'package:chess_former/game_structure/position.dart';

class Level {
  // initial player position
  Position playerPosition = Position(x: 1, y: 1);

  // parent
  // Position? parent;

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

  @override
  String toString() {
    return 'Level{playerPosition: $playerPosition}';
  }
}

class WeightedLevel{
  Position playerPosition = Position(x: 1, y: 1);
  int weight;
  WeightedLevel({required this.playerPosition,required this.weight});

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightedLevel &&
          runtimeType == other.runtimeType &&
          playerPosition == other.playerPosition;

  @override
  int get hashCode => playerPosition.hashCode;

  @override
  String toString() {
    return 'WeightedLevel{playerPosition: $playerPosition, weight: $weight}';
  }

}

class HeroStickyLevel{
  Position playerPosition = Position(x: 1, y: 1);
  int weight;
  int heroStickValue;
  HeroStickyLevel({required this.playerPosition,required this.weight,required this.heroStickValue});

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeroStickyLevel &&
          runtimeType == other.runtimeType &&
          playerPosition == other.playerPosition &&
          weight == other.weight &&
          heroStickValue == other.heroStickValue;

  @override
  int get hashCode =>
      playerPosition.hashCode ^ weight.hashCode ^ heroStickValue.hashCode;

  @override
  String toString() {
    return 'HeroStickyLevel{playerPosition: $playerPosition, weight: $weight, heroStickValue: $heroStickValue}';
  }
}
