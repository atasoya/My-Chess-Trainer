import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:my_chess_trainer/screens/home_page/widgets/HomePageButton.dart';
import 'globals.dart' as globals;
import 'package:chess/chess.dart' as ch;
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart'
    as cb;

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({Key? key}) : super(key: key);

  @override
  _PuzzleScreenState createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  String _fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";
  var white_oriantation = cb.Color.WHITE;
  var black_oriantation = cb.Color.BLACK;
  var oriantation = cb.Color.BLACK;
  String text = "LOADING...";

  void getData() async {
    Response response =
        await get(Uri.parse("https://lichess.org/api/puzzle/daily"));
    Map data = jsonDecode(response.body);
    print(data);
    globals.apiData = data;
    var virtualBoard = ch.Chess();
    List splitPgn = globals.apiData["game"]["pgn"].split(" ");
    print("list? $splitPgn");
    virtualBoard.load_pgn(globals.apiData["game"]["pgn"]);
    globals.uiChessBoard = virtualBoard;
    setState(() {
      _fen = virtualBoard.fen;
      text = " ";

      if (splitPgn.length % 2 == 0) {
        oriantation = white_oriantation;
      } else {
        oriantation = black_oriantation;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  int moveCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF686D76),
      appBar: AppBar(
        title: Text(
          "My Chess Trainer",
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
                // check if move is correct
                var userMove = move.from + move.to;
                
                print(userMove);
                print(globals.apiData["puzzle"]["solution"]);
                if (moveCounter !=
                    globals.apiData["puzzle"]["solution"].length - 1) {
                  if (userMove ==
                      globals.apiData["puzzle"]["solution"][moveCounter]) {
                    print("nice");
                    var virtualBoard = ch.Chess.fromFEN(_fen);
                    virtualBoard.move({"from": move.from, "to": move.to});
                    var bestFrom = globals.apiData["puzzle"]["solution"]
                            [moveCounter + 1]
                        .substring(0, 2);
                    var bestTo = globals.apiData["puzzle"]["solution"]
                            [moveCounter + 1]
                        .substring(2, 4);
                    print("$bestTo $bestFrom");
                    print(virtualBoard.move({"from": bestFrom, "to": bestTo}));
                    moveCounter += 2;
                    setState(() {
                      _fen = virtualBoard.fen;
                    });
                  }
                } else {
                  if (userMove ==
                      globals.apiData["puzzle"]["solution"][moveCounter]) {
                    print("done");
                    var virtualBoard = ch.Chess.fromFEN(_fen);
                    virtualBoard.move({"from": move.from, "to": move.to});
                    setState(() {
                      _fen = virtualBoard.fen;
                      text = "Solved Successfully";
                    });
                  }
                }
              },
              orientation: oriantation, // optional
              lightSquareColor: Color.fromRGBO(240, 217, 181, 1), // optional
              darkSquareColor: Color.fromRGBO(181, 136, 99, 1)),
          SizedBox(
            height: 40,
          ),
          Text(text,
              style: TextStyle(
                  fontSize: 20, letterSpacing: 1, color: Colors.white)),
        ],
      )),
    );
  }
}
