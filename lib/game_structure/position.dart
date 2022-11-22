class Position {
  int x, y;
  Position({
    required this.x,
    required this.y,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() {
    return 'Position{x: $x, y: $y}';
  }
}
