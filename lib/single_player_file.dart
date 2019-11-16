import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tic_tac_toe_starter/custom_widgets.dart';
import 'package:tic_tac_toe_starter/gamelogic.dart';

class OneBox extends StatefulWidget {
  final Widget buttonChild;
  final Function onPressed;
  final Color colors;
  OneBox(
      {this.buttonChild = const Text(''),
      this.onPressed,
      this.colors = Colors.white24});

  @override
  _OneBoxState createState() => _OneBoxState();
  Widget build(BuildContext context) {
    return null;
  }

  BuildContext get context => null;

  StatefulWidget get widget => null;
}

class _OneBoxState extends State<OneBox> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
      value: 0.0,
    );
    super.initState();
  }

  Widget build(BuildContext context) {
    //CurvedAnimation animation1 = CurvedAnimation(parent: controller, curve: Curves.easeInExpo);
    CurvedAnimation animation =
        CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    return GestureDetector(
      onTap: () {
        widget.onPressed();
        controller.forward();
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        alignment: Alignment.center,
        child: widget.buttonChild,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: widget.colors,
          border: Border.all(
            color: Colors.white10,
            width: 14,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
    );
  }
}

class TicTacToePage extends StatefulWidget {
  String playerName;
  TicTacToePage(this.playerName);
  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage>
    with SingleTickerProviderStateMixin {
  void initState() {
    controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
      value: 1.0,
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
        setState(() {});
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
        setState(() {});
      }
    });

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
    super.initState();
  }

  Widget drawIcon(token t) {
    if (t == token.o) {
      return CustomIcon(
        Icons.radio_button_unchecked,
      );
    } else if (t == token.x) {
      return CustomIcon(
        Icons.close,
      );
    } else
      return null;
  }

  Color getColor(int row, int col) {
    return colorBoard[row][col]
        ? Colors.green.withAlpha(255)
        : Colors.transparent;
  }
bool isPlaying = false;
  Widget singleExpandedBox(int row, int col) {
    return Expanded(
      child: OneBox(
        buttonChild: drawIcon(board[row][col]),
        colors: getColor(row, col),
        onPressed: () async {
            if (isPlaying == false) {
              isPlaying = true;
              currentPlayer = token.x;
              updateBox(row, col);

            if (!winnerCheck(board, currentPlayer) && !fullBoard(board)) {
              Future.delayed(const Duration(milliseconds: 1500), () {
                setState(() {
                  currentPlayer = token.o;
                });
                computersTurn();
              });
              setState(() {});
            }
            isPlaying = false;
          }
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

  void computersTurn() {
    final _random = new Random();
    int row = _random.nextInt(3);
    int col = _random.nextInt(3);

    if (legitMove(board[row][col])) {
      board[row][col] = token.o;
    } else {
      computersTurn();
    }

    if (winnerCheck(board, currentPlayer) && !fullBoard(board)) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          currentPlayer = token.x;
        });
      });
    }
  }

  Color playerColor = Colors.white.withAlpha(150);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD6AA7C),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.0, 0.5, 0.9],
            colors: [
              Color.fromARGB(255, 0, 0, 55),
              Colors.blue,
              Colors.blueGrey,
            ],
          ),

          // image: DecorationImage(
          // image: NetworkImage('https://www.elsetge.cat/myimg/f/73-736820_dark-blue-green-gradient-4k-iphone-xs-max.jpg'), fit: BoxFit.cover)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '${widget.playerName}',
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'QuickSand',
                          color: Colors.white),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: new BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: new BorderRadius.only(
                                      bottomLeft: const Radius.circular(40.0),
                                      topLeft: const Radius.circular(40.0),
                                  ),
                                border: Border.all(
                                    color: Colors.white
                                )
                            ),
                            child: Text('$playerScore',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: 'QuickSand',
                                  color: Colors.white),textAlign: TextAlign.center,),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: new BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: new BorderRadius.only(
                                bottomRight: const Radius.circular(40.0),
                                topRight: const Radius.circular(40.0),
                              ),
                                border: Border.all(
                                    color: Colors.white
                                )
                            ),
                            child: Text('$computerScore',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: 'QuickSand',
                                  color: Colors.white),textAlign: TextAlign.center,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Bots',
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'QuickSand',
                          color: Colors.white),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: winnerCheck(board, currentPlayer)
                    ? ScaleTransition(
                        scale: Tween(begin: 1.5, end: 2.5).animate(controller),
                        child: Text(
                          "${getCurrentStatus(board)}",
                          style: TextStyle(
                              fontSize: 24,
                              color: winnerCheck(board, currentPlayer)
                                  ? ColorTween(
                                          begin: Colors.white,
                                          end: Colors.orange)
                                      .transform(controller.value)
                                  : Colors.white,
                              fontFamily: 'Quicksand'),
                        ),
                      )
                    : Text(
                        "${getCurrentStatus(board)}",
                        style: TextStyle(
                            fontSize: 24,
                            color: winnerCheck(board, currentPlayer)
                                ? ColorTween(
                                        begin: Colors.white, end: Colors.orange)
                                    .transform(controller.value)
                                : Colors.white,
                            fontFamily: 'Quicksand'),
                      ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(width: 16, color: Colors.transparent)),
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
                      child: IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        iconSize: 72,
                        color: Color(0xFF848AC1),
                        onPressed: () {
                          gameReset();
                          setState(() {});
                        },
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

        setState(() {});
      }
      //changePlayerIfGameNotOver();
    }
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
