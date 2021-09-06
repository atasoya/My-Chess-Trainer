import 'package:flutter/material.dart';
import 'widgets/HomePageButton.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF686D76),
      appBar: AppBar(
        title: Text("My Chess Trainer",style: TextStyle(color:Color(0xFFEEEEEE),fontFamily: "Roboto" ,fontSize: MediaQuery.of(context).size.height/30),), // font u düzelt
        centerTitle: true,
        backgroundColor: Color(0xFF373A40) ,
      ),
      body: Center(
        child: Column(children: [
          SizedBox(height: MediaQuery.of(context).size.height/7,), // sized box space
          HomePageButton(text: "Daily Puzzle",),
          SizedBox(height: MediaQuery.of(context).size.height/18,),
          HomePageButton(text: "Random Puzzle"),
          SizedBox(height: MediaQuery.of(context).size.height/18,),
          HomePageButton(text: "960 Position"),
          SizedBox(height: MediaQuery.of(context).size.height/18,),
          HomePageButton(text: "Play Aganist Friend"),
        ],)
        ),
    );
  }
}