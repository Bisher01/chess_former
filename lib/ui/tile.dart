import 'package:chess_former/structure/position.dart';
import 'package:flutter/material.dart';
// this is just a widget to draw a tile
class Tile extends StatelessWidget {
  final Position position;
  final String type;
  final Function() onPlayerTap;
  final Function()? onDotTap;
  final bool dot;
  late final String image;
  Tile({
    Key? key,
    required this.position,
    required this.type,
    required this.onPlayerTap,
    required this.dot,
    this.onDotTap
  }) : super(key: key) {
    if (type == 'wall') {
        image = 'assets/wall.png';
    } else {
      if ((position.x + position.y) % 2 == 0) {
        image = 'assets/light_tile.png';
      } else {
        image = 'assets/dark_tile.png';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
        ),
      ),
      child: type=='goal' && dot?Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/red-flag.png'),
          InkWell(
            onTap: onDotTap,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
          )
        ],
      ):
      type == 'goal'
              ? Image.asset('assets/red-flag.png')
              : dot
                  ? InkWell(
        onTap: onDotTap,
                    child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                  )
                  : const SizedBox(),
    );
  }
}
