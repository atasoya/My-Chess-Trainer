import 'package:flutter/material.dart';
import 'package:my_chess_trainer/screens/play_aganist_friend_screen/play_aganist_friend_screen.dart';
import 'screens/home_page/home_page.dart';
import 'package:my_chess_trainer/screens/play_aganist_ai_screen/play_aganist_ai_screen.dart';
import 'screens/daily_puzzle_screen/daily_puzzle_screen.dart';
import 'screens/random_puzzle_screen/random_puzzle_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        "/daily_puzzle":(context) => PuzzleScreen(),
        "/random_puzzle":(context) => RandomPuzzleScreen(),
        "/960_screen":(context) => AiScreen(),
        "/friend_screen":(context) => FriendScreen(),
      },
    );
  }
}

