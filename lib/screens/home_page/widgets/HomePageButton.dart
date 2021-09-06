import 'package:flutter/material.dart';
import 'package:my_chess_trainer/screens/daily_puzzle_screen/daily_puzzle_screen.dart';

class HomePageButton extends StatelessWidget {
  final String text;
  const HomePageButton({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ()=>{
        if(text=="Daily Puzzle"){
          Navigator.pushNamed(context, '/daily_puzzle')
        }else if(text=="Random Puzzle"){
          Navigator.pushNamed(context, '/random_puzzle')
        }else if(text=="960 Position"){
          Navigator.pushNamed(context, "/960_screen")
        }else if(text=="Play Aganist Friend"){
          Navigator.pushNamed(context, "/friend_screen")
        }
      },
       child: Text(text,style: TextStyle(fontSize: MediaQuery.of(context).size.height/25 ),),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF19D3DA),
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
        minimumSize: Size(MediaQuery.of(context).size.width/1.1, MediaQuery.of(context).size.height/10.5),
      ),
      );
  }
}
