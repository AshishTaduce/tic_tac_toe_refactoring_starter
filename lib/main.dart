import 'package:tic_tac_toe_starter/single_player_file.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: FrontPage(),
  ));
}

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.pink,
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            // Where the linear gradient begins and ends
//            begin: Alignment.top,
//            end: Alignment.bottom,
//            // Add one stop for each color. Stops should increase from 0 to 1
//            stops: [0.1, 0.5, 0.7, 0.9],
//            colors: [
//
//              Colors.yellow[800],
//              Colors.indigo[700],
//              Colors.indigo[600],
//              Colors.indigo[400],
//            ],
//          ),
//        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.1,
            ),
            Text(
              "Tic-Tac-Toe",
              style: TextStyle(
                  fontSize: 60,
                  color: Colors.yellow,
                  fontFamily: 'Quicksand'),
            ),
            SizedBox(
              height: size.height * 0.3,
            ),
            Center(
              child: ButtonTheme(
                minWidth: 200,
                height: 80,
                child: RaisedButton(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.yellow),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  color: Colors.yellow,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TicTacToePage()));
                  },
                  child: Text(
                    "Player VS Computer",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.pink,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
