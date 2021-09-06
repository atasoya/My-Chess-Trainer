import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:my_chess_trainer/screens/home_page/widgets/HomePageButton.dart';
import 'package:chess/chess.dart' as ch;
import 'package:chess960/chess960.dart' as c960;
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart'
    as cb;
import 'package:my_chess_trainer/screens/play_aganist_friend_screen/globals.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  String _fen = "rnknqrbb/pppppppp/8/8/8/8/PPPPPPPP/RNKNQRBB w KQkq - 0 1";
  var oriantation = cb.Color.WHITE;
  var white_oriantation = cb.Color.WHITE;
  var black_oriantation = cb.Color.BLACK;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    globalGameObject = ch.Chess();
    setState(() {
      _fen = globalGameObject.fen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF686D76),
      appBar: AppBar(
        title: Text(
          "Play vs Friend",
          style: TextStyle(
              color: Color(0xFFEEEEEE),
              fontFamily: "Roboto",
              fontSize: MediaQuery.of(context).size.height / 30),
        ), // font u düzelt
        centerTitle: true,
        backgroundColor: Color(0xFF373A40),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            cb.Chessboard(
                size: MediaQuery.of(context).size.height / 2.2,
                fen: _fen,
                onMove: (move) {
                  if (globalGameObject
                      .move({"from": move.from, "to": move.to})) {
                    setState(() {
                      _fen = globalGameObject.fen;
                      if (oriantation == white_oriantation) {
                        oriantation = black_oriantation;
                      } else {
                        oriantation = white_oriantation;
                      }
                    });
                  }
                },
                orientation: oriantation,
                lightSquareColor: Color.fromRGBO(240, 217, 181, 1),
                darkSquareColor: Color.fromRGBO(181, 136, 99, 1)),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                globalGameObject = ch.Chess();
                setState(() {
                  _fen = globalGameObject.fen;
                  oriantation = white_oriantation;
                });
              },
              child: Text(
                "Start New Game",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 25),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF19D3DA),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10),
                ),
                minimumSize: Size(MediaQuery.of(context).size.width / 1.1,
                    MediaQuery.of(context).size.height / 10.5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
