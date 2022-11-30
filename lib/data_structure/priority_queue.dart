import 'package:chess_former/game_structure/map.dart';
class PriorityQueue {
  List<WeightedLevel> queue = <WeightedLevel>[];
  PriorityQueue();

  enqueue(WeightedLevel value) {
    queue.add(value);
    queue.sort((a, b) {
      return a.weight - b.weight;
    });
  }

  dequeue() {
    return queue.removeAt(0);
  }

  bool isEmpty() {
    return queue.isEmpty;
  }

  bool notEmpty() {
    return queue.isNotEmpty;
  }
}

class APriorityQueue {
  List<HeroStickyLevel> queue = <HeroStickyLevel>[];
  APriorityQueue();

  enqueue(HeroStickyLevel value) {
    queue.add(value);
    queue.sort((a, b) {
      return (a.weight+a.heroStickValue) - (b.weight+b.heroStickValue);
    });
  }

  dequeue() {
    return queue.removeAt(0);
  }

  bool isEmpty() {
    return queue.isEmpty;
  }

  bool notEmpty() {
    return queue.isNotEmpty;
  }
}