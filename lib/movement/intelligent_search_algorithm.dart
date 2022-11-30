import 'package:chess_former/data_structure/priority_queue.dart';
import 'package:chess_former/game_structure/position.dart';
import 'package:chess_former/data_structure/stack.dart';
import '../data_structure/queue.dart';
import '../game_structure/map.dart';
import 'dart:math' as math;

class ISA {
  List<Position> availablePosition = [];
  Level level = Level(playerPosition: Position(x: 1, y: 1));

  void clearAvailableMoves() => availablePosition = [];

  List<Position> checkMoveAI(Position currentPosition) {
    List<List<String>> map = level.level2;
    clearAvailableMoves();

    // check right
    for (int i = currentPosition.y + 1; i < 16; i++) {
      if (map[currentPosition.x][i] == 'wall') {
        break;
      } else {
        Position finalPos =
            checkGravityAI(Position(x: currentPosition.x, y: i));
        availablePosition.add(finalPos);
      }
    }

    //check left
    for (int i = currentPosition.y - 1; i >= 0; i--) {
      if (map[currentPosition.x][i] == 'wall') {
        break;
      } else {
        Position finalPos =
            checkGravityAI(Position(x: currentPosition.x, y: i));
        availablePosition.add(finalPos);
      }
    }
    return availablePosition;
  }

  Position checkGravityAI(Position playerPosition) {
    List<List<String>> map = level.level2;
    int finalPos = playerPosition.x;
    for (int i = playerPosition.x; i < 10; i++) {
      if (map[i + 1][playerPosition.y] == 'wall') {
        finalPos = i;
        break;
      }
    }
    return Position(x: finalPos, y: playerPosition.y);
  }

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

  bool checkWinAI(Position playerPosition) {
    Position targetPosition = getTargetPosition();
    if (playerPosition == targetPosition) {
      return true;
    } else {
      return false;
    }
  }

  List<Level> getNextState(Position position) {
    List<Level> nextState = <Level>[];
    List<Position> positions = checkMoveAI(position);
    for (Position pos in positions) {
      Level l = Level(playerPosition: level.playerPosition)
          .copyWith(playerPosition: pos);
      nextState.add(l);
    }
    return nextState;
  }

  // Method to calculate the heroStick value for each position
  // It's supposed to be heuristic, but I don't know how to spell it
  int heroStick(Position playerPosition) {
    Position target = Position(x: 9, y: 9);
    if (playerPosition.x == target.x) {
      return (playerPosition.y - target.y).abs();
    } else {
      Position hole;
      for (int i = playerPosition.y + 1; i < 16; i++) {
        if (level.level2[playerPosition.x + 1][i] == 'cell') {
          hole = Position(x: playerPosition.x, y: i);
          Position endOfHole = checkGravityAI(hole);
          if (endOfHole.x > target.x) {
            return 100;
          } else {
            return (hole.y - playerPosition.y).abs();
          }
        }
      }
      for (int i = playerPosition.y; i > 0; i--) {
        if (level.level2[playerPosition.x + 1][i] == 'cell') {
          hole = Position(x: playerPosition.x, y: i);
          Position endOfHole = checkGravityAI(hole);
          if (endOfHole.x > target.x) {
            return 100;
          } else {
            return (hole.y - playerPosition.y).abs();
          }
        }
      }
    }
    return 100;
  }

  List<Level> bfs(Level source) {
    // queue keeps track of the neighboring vertices to visit next.
    final queue = QueueStack<Level>();
    // enqueued remembers which vertices have been enqueued before,
    // so you don’t enqueue the same vertex twice.
    // You use Set so that lookup is cheap and only takes O(1) time.
    // A list would require O(n) time.
    final Set<Level> enqueued = {};
    // visited is a list that stores the order in which the vertices were explored.
    final List<Level> visited = [];

    queue.enqueue(source);
    enqueued.add(source);

    while (true) {
      final level = queue.dequeue();
      if (level == null) {
        break;
      }
      print('x=${level.playerPosition.x}, y=${level.playerPosition.y}');
      if (checkWinAI(level.playerPosition)) {
        print('win');
        break;
      }
      visited.add(level);
      final neighbors = getNextState(level.playerPosition);
      for (final l in neighbors) {
        if (!enqueued.contains(l)) {
          print(
              'not visited x= ${l.playerPosition.x} , y= ${l.playerPosition.y}');
          queue.enqueue(l);
          enqueued.add(l);
        }
      }
    }
    print(visited.length);
    print(visited.toString());
    return visited;
  }

  List<Level> dfs(Level source) {
    // stack is used to store your path through the graph.
    final stack = StackList<Level>();
    // pushed is a set that remembers which vertices have been pushed before so that
    // you don’t visit the same vertex twice. Using Set ensures fast O(1) lookup.
    final Set<Level> pushed = <Level>{};
    // visited is a list that stores the order in which the vertices were visited.
    final List<Level> visited = <Level>[];

    stack.push(source);
    pushed.add(source);
    visited.add(source);

    outerLoop:
    while (stack.isNotEmpty) {
      final level = stack.peek;
      print('x=${level.playerPosition.x}, y=${level.playerPosition.y}');
      if (checkWinAI(level.playerPosition)) {
        print('win');
        break;
      }
      final neighbors = getNextState(level.playerPosition);
      for (final l in neighbors) {
        if (!pushed.contains(l)) {
          print(
              'not visited x= ${l.playerPosition.x} , y= ${l.playerPosition.y}');
          stack.push(l);
          pushed.add(l);
          visited.add(l);
          continue outerLoop;
        }
      }
      stack.pop();
    }
    print(visited.length);
    print(visited.toString());
    return visited;
  }

  List<WeightedLevel> ucs(WeightedLevel initialLevel) {
    PriorityQueue queue = PriorityQueue();
    Set<Level> added = <Level>{};
    List<WeightedLevel> visited = <WeightedLevel>[];

    queue.enqueue(initialLevel);
    added.add(Level(playerPosition: initialLevel.playerPosition));

    while (true) {
      final level = queue.dequeue();
      if (checkWinAI(level!.playerPosition)) {
        print('win!');
        break;
      }
      visited.add(level);
      final neighbors = getNextState(level.playerPosition);
      for (var neighbor in neighbors) {
        if (!added.contains(neighbor)) {
          queue.enqueue(
            WeightedLevel(
                playerPosition: neighbor.playerPosition,
                weight: level.weight + 1),
          );
          added.add(neighbor);
        }
      }
    }
    print(visited.toString());
    print(visited.length);
    return visited;
  }

  List<HeroStickyLevel> aStar(HeroStickyLevel initialLevel) {
    APriorityQueue queue = APriorityQueue();
    Set<Level> added = <Level>{};
    List<HeroStickyLevel> visited = <HeroStickyLevel>[];

    queue.enqueue(initialLevel);
    added.add(Level(playerPosition: initialLevel.playerPosition));

    while (true) {
      final level = queue.dequeue();
      if (checkWinAI(level!.playerPosition)) {
        print('win!');
        break;
      }
      visited.add(level);
      final neighbors = getNextState(level.playerPosition);
      for (var neighbor in neighbors) {
        if (!added.contains(neighbor)) {
          queue.enqueue(
            HeroStickyLevel(
              playerPosition: neighbor.playerPosition,
              weight: level.weight + 1,
              heroStickValue: heroStick(neighbor.playerPosition),
            ),
          );
          added.add(neighbor);
        }
      }
    }
    print(visited.length);
    print(visited.toString());
    return visited;
  }
}
