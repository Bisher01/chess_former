import 'package:chess_former/ui/tile.dart';
import 'package:flutter/material.dart';
import 'package:chess_former/structure/map.dart';
import 'package:provider/provider.dart';
import '../structure/move.dart';
import '../structure/position.dart';

// a widget to draw our game board and animate the player
class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {

  Move move = Move();
  late final List<List<String>> map;
  @override
  void initState() {
    map = move.level.level2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.4),
      body: Consumer<Move>(builder: (context, manager, child) {
        return Center(
          child: SizedBox(
            width: 1120,
            height: 770,
            child: Stack(
              fit: StackFit.loose,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    map.length,
                    (x) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        map[x].length,
                        (y) {
                          return Tile(
                            position: Position(x: x, y: y),
                            type: map[x][y],
                            dot: manager.availableMoves[x][y],
                            onPlayerTap: () {
                              manager.checkMove();
                            },
                            onDotTap: manager.availableMoves[x][y]
                                ? () {
                                    manager.movePlayer(
                                      Position(x: x, y: y),
                                      context,
                                    );
                                  }
                                : null,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  top: manager.top,
                  left: manager.left,
                  duration: Duration(milliseconds: manager.duration),
                  curve: Curves.ease,
                  child: InkWell(
                    onTap: () {
                      manager.checkMove();
                    },
                    child: Image.asset(
                      'assets/rook.png',
                      height: 70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
