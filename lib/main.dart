import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'gamelogic.dart';
void main() {
  runApp(MaterialApp(
    home: TicTacToePage(),
  ));
}
class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}
class _TicTacToePageState extends State<TicTacToePage> with SingleTickerProviderStateMixin{
  Widget getIcon(token t) {
    if (t == token.o) {
      return Icon(
        Icons.radio_button_unchecked,
        size: 80,
        color: Colors.white,
      );
    }
    else if (t == token.x) {
      return Icon(
        Icons.close,
        size: 80,
        color: Colors.white,
      );
    } else
      return null;
  }
  Color getColor(int row, int col) {
    return colorBoard[row][col]
        ? Colors.green.withAlpha(255)
        : Colors.white.withAlpha(150);
  }
  Widget singleExpandedBox(int row, int col) {
    return Expanded(
      child: OneBox(
        buttonChild: getIcon(board[row][col]),
        colors: getColor(row, col),
        onPressed: () {
          updateBox(row, col);
          setState(() {});
        },
      ),
    );
  }
  Widget expandedRow(int row) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          singleExpandedBox(row, 0),
          singleExpandedBox(row, 1),
          singleExpandedBox(row, 2),
        ],
      ),
    );
  }
  AnimationController controller;
  @override

  void initState() {
    controller = AnimationController(
      duration: Duration(milliseconds: 700), vsync: this, value: 1.0,
    );
    controller.addStatusListener((status){
      if (status == AnimationStatus.completed) {
        setState(() {
        });
        controller.reverse();
      }
      else if (status == AnimationStatus.dismissed) {
        controller.forward();
        setState(() {
        });
      }
    });
    controller.addListener((){
      setState(() {

      });
    });
    controller.forward();
    super.initState();
  }
  Color playerColor = Colors.white.withAlpha(150);
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFD6AA7C),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/tictactoe03.jpg'), fit: BoxFit.cover)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Tic-Tac-Toe",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontFamily: 'Quicksand'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: winnerCheck(board) ? ScaleTransition(
                  scale : Tween(begin: 1.5, end: 2.5).animate(controller),
                  child: Text(
                    "${getCurrentStatus(board)}",
                    style: TextStyle(
                        fontSize: 24,
                        color: winnerCheck(board) ? ColorTween(begin: Colors.white, end: Colors.orange).transform(controller.value) : Colors.white,
                        fontFamily: 'Quicksand'),
                  ),
                ) : Text(
                  "${getCurrentStatus(board)}",
                  style: TextStyle(
                      fontSize: 24,
                      color: winnerCheck(board) ? ColorTween(begin: Colors.white, end: Colors.orange).transform(controller.value) : Colors.white,
                      fontFamily: 'Quicksand'),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                margin: EdgeInsets.all(6),
                child: Column(
                  children: <Widget>[
                    expandedRow(0),
                    expandedRow(1),
                    expandedRow(2),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      child: FlatButton(
                        color: Color(0xFF848AC1),
                        onPressed: () {
                          gameReset();
                          setState(() {});
                        },
                        child: Text("Reset",
                            style:
                            TextStyle(fontSize: 25, color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateBox(int r, int c) {
    if (legitMove(board[r][c])) {
      if (currentPlayer == token.x) {
        board[r][c] = token.x;
      } else {
        board[r][c] = token.o;
      }
      changePlayerIfGameNotOver();
    }
  }
}
class OneBox extends StatefulWidget {
  final Widget buttonChild; final Function onPressed; final Color colors;
  OneBox({this.buttonChild = const Text(''), this.onPressed, this.colors = Colors.white24});

  @override
  _OneBoxState createState() => _OneBoxState();
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
  // TODO: implement context
  BuildContext get context => null;
  void deactivate() {
    // TODO: implement deactivate
  }
  void didUpdateWidget(StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
  }
  void initState() {
    // TODO: implement initState
  }// TODO: implement mounted
  bool get mounted => null;
  void reassemble() {
    // TODO: implement reassemble
  }
  void setState(fn) {
    // TODO: implement setState
  }
  // TODO: implement widget
  StatefulWidget get widget => null;
}
class _OneBoxState extends State<OneBox> with SingleTickerProviderStateMixin{

  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(milliseconds: 800), vsync: this, value: 0.0,
    );
    super.initState();
  }
  Widget build(BuildContext context) {
    CurvedAnimation animation1 = CurvedAnimation(parent: controller, curve: Curves.easeInExpo);
    CurvedAnimation animation2 = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    return GestureDetector(
      onTap: (){
        widget.onPressed();
        controller.forward();

      },
      child: Container(
        alignment: Alignment.center,
        child: FadeTransition(
            opacity: controller,
            child: ScaleTransition(
              child: widget.buttonChild,
            scale: Tween(begin: 2.0, end: 1.0).animate(animation2),
            )),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: widget.colors,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
    );
  }
}