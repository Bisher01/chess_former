import 'package:chess_former/movement/user_play.dart';
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
        ChangeNotifierProvider(
          create: (context) => Play(),
        ),
      ],
      child: const MaterialApp(
        home: Board(),
        title: 'Chess Former by BISHER',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
