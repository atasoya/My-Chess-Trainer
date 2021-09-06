import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:chess/chess.dart' as ch;
import 'package:my_chess_trainer/screens/random_puzzle_screen/globals.dart';
import 'puzzles.dart';
import 'globals.dart' as gb;
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart'
    as cb;

class RandomPuzzleScreen extends StatefulWidget {
  const RandomPuzzleScreen({Key? key}) : super(key: key);

  @override
  _RandomPuzzleScreenState createState() => _RandomPuzzleScreenState();
}

class _RandomPuzzleScreenState extends State<RandomPuzzleScreen> {
  String _fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";
  var text = " ";
  int moveCounter = 0;
  var white_oriantation = cb.Color.WHITE;
  var black_oriantation = cb.Color.BLACK;
  var oriantation = cb.Color.BLACK;
  var whiteornot = true;

  void setBoard() async {
    var randomItem = (puzzles.toList()..shuffle()).first;
    print(randomItem);
    var data = randomItem.split(",");
    var _fen = data[0];
    gb.globalFen = _fen;
    var answer = data[1];
    var wgiteornot = globalFen.contains(new RegExp(r'w', caseSensitive: false));
    print("fen : $_fen");
    print(wgiteornot);
    globalAnswer = answer.split(" ");
    setState(() {
      text = " ";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF686D76),
        appBar: AppBar(
          title: Text(
            "Random Puzzles",
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
                    var userMove = move.from + move.to;
                    if (moveCounter != globalAnswer.length - 1) {
                      if (userMove == globalAnswer[moveCounter]) {
                        print("correct move");
                        var virtualBoard = ch.Chess.fromFEN(gb.globalFen);
                        virtualBoard.move({"from": move.from, "to": move.to});
                        var bestFrom =
                            globalAnswer[moveCounter + 1].substring(0, 2);
                        var bestTo =
                            globalAnswer[moveCounter + 1].substring(2, 4);
                        virtualBoard.move({"from": bestFrom, "to": bestTo});
                        moveCounter += 2;
                        gb.globalFen = virtualBoard.fen;
                        setState(() {
                          _fen = gb.globalFen;
                        });
                      }
                    } else {
                      print("last move man");
                      if (userMove == globalAnswer[moveCounter]) {
                        var virtualBoard = ch.Chess.fromFEN(gb.globalFen);
                        virtualBoard.move({"from": move.from, "to": move.to});
                        setState(() {
                          _fen = virtualBoard.fen;
                          text = "Solved Successfully";
                        });
                        moveCounter = 0;
                      }
                    }
                  },
                  orientation: oriantation,
                  lightSquareColor: Color.fromRGBO(240, 217, 181, 1),
                  darkSquareColor: Color.fromRGBO(181, 136, 99, 1)),
              SizedBox(
                height: 20,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setBoard();
                  moveCounter = 0;
                  print(globalAnswer);
                  var virtualBoard = ch.Chess.fromFEN(gb.globalFen);
                  var bestFrom = globalAnswer[0].substring(0, 2);
                  var bestTo = globalAnswer[0].substring(2, 4);
                  print("$bestFrom $bestTo");

                  print(virtualBoard.move({"from": bestFrom, "to": bestTo}));
                  globalAnswer.removeAt(0);
                  gb.globalFen = virtualBoard.fen;
                  print(virtualBoard.turn);

                  setState(() {
                    _fen = virtualBoard.fen;
                    text = virtualBoard.turn
                            .toString()
                            .substring(6, virtualBoard.turn.toString().length) +
                        " to move";
                    print(text =="WHITE to move");
                    if (text == "WHITE to move") {
                      oriantation = white_oriantation;
                    } else {
                      oriantation = black_oriantation;
                    }
                  });
                },
                child: Text(
                  "New Position",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 25),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF19D3DA),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                  minimumSize: Size(MediaQuery.of(context).size.width / 1.1,
                      MediaQuery.of(context).size.height / 10.5),
                ),
              )
            ],
          ),
        ));
  }
}
