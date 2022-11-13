import 'package:chess_former/structure/move.dart';
import 'package:chess_former/ui/board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> Move()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chess Former',
        home: Board(),
      ),
    );
  }
}

