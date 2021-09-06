import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:my_chess_trainer/screens/home_page/widgets/HomePageButton.dart';
import 'package:chess/chess.dart' as ch;
import 'package:chess960/chess960.dart' as c960;
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart'
    as cb;

class AiScreen extends StatefulWidget {
  const AiScreen({Key? key}) : super(key: key);

  @override
  _AiScreenState createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  String _fen = "rnknqrbb/pppppppp/8/8/8/8/PPPPPPPP/RNKNQRBB w KQkq - 0 1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var position = new c960.Chess960();
    print(position.fen);
    setState(() {
      _fen = position.fen;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF686D76),
      appBar: AppBar(
        title: Text(
          "960 Position",
          style: TextStyle(
              color: Color(0xFFEEEEEE),
              fontFamily: "Roboto",
              fontSize: MediaQuery.of(context).size.height / 30),
        ),
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
                onMove: (move) {},
                orientation: cb.Color.WHITE,
                lightSquareColor: Color.fromRGBO(240, 217, 181, 1),
                darkSquareColor: Color.fromRGBO(181, 136, 99, 1)),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                var position = new c960.Chess960();
                print(position.fen);
                setState(() {
                  _fen = position.fen;
                });
              },
              child: Text(
                "Generate New Position",
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
