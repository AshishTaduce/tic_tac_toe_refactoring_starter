import 'package:flutter/material.dart';

enum Token{ True, False,
}

enum Player{ x, y,
}

generateColor(List<List> colorBoard) {

}
buildCell(int i, int j) {
  return GestureDetector(
    onTap: () {
      winnerCheck(board);
    },
    child: Container(
      margin: EdgeInsets.fromLTRB(12, 8, 8, 8),
      width: 90.0,
      height: 90.0,
      decoration: BoxDecoration(
          color: Colors.white.withAlpha(150),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border: Border.all(
            color: Colors.white,
          )),
      child: Center(
        child: AnimatedOpacity(
          opacity: 0.5,
          duration: Duration(milliseconds: 700),
          child: Icon(
            Icons.threesixty,
            color: Colors.white,
            size: 80,
          ),
        ),
      ),
    ),
  );
}

initMatrix() {
  board = List<List>(3);
  for (var i = 0; i < board.length; i++) {
    board[i] = List(3);
    for (var j = 0; j < board[i].length; j++) {
      board[i][j] = Token.False;
    }
  }
}

initColor() {
  colorBoard = List<List>(3);
  for (var i = 0; i < colorBoard.length; i++) {
    colorBoard[i] = List(3);
    for (var j = 0; j < colorBoard[i].length; j++) {
      colorBoard[i][j] = Colors.white24;
    }
  }
}

List<List> board = [
  [Token.False, Token.False, Token.False],
  [Token.False, Token.False, Token.False],
  [Token.False, Token.False, Token.False],];

// initial list of colors assigned to boxes on board
List<List> colorBoard = [
  [Colors.white24, Colors.white24, Colors.white24],
  [Colors.white24, Colors.white24, Colors.white24],
  [Colors.white24, Colors.white24, Colors.white24]
];

//  takes a state, checks if
bool legitMove(Token s) {
  return s == null && !winnerCheck(board);
}

//default parameters
String currentPlayer = 'Player X Move'; //X will always be player 1
Icon xIcon = Icon(
  Icons.close,
  size: 70,
);
Icon oIcon = Icon(
  Icons.radio_button_unchecked,
  size: 70,
);
Icon playerIcon;

//function to change player based on currentPlayer value which is a string,
changePlayer(String x) {
  if (x == 'Player X Move') {
    currentPlayer = 'Player O Move';
  } else if (x == 'Player O Move') {
    currentPlayer = 'Player X Move';
  }
}

Color winningColor = Colors.yellow.withOpacity(0.2);
void gameReset() {
  board = [
    [null, null, null],
    [null, null, null],
    [null, null, null]
  ];
  colorBoard = [
    [Colors.white24, Colors.white24, Colors.white24],
    [Colors.white24, Colors.white24, Colors.white24],
    [Colors.white24, Colors.white24, Colors.white24]
  ];
  currentPlayer = 'Player X Move';
}

bool fullBoard(List<List<Token>> board) {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == null)
        return false;
    }
  }
  return true;
}

bool winnerCheck(List<List<Token>> board) {
  for (int x = 0; x < 3; x++) {
    for (int y = 0; y < 3; y++) {
      var col = 0,
          row = 0,
          diag = 0,
          rdiag = 0;
      var n = board.length - 1;
      var player = board[x][y];

      for (int i = 0; i < board.length; i++) {
        if (board[x][i] == player) col++;
        if (board[i][y] == player) row++;
        if (board[i][i] == player) diag++;
        if (board[i][n - i] == player) rdiag++;
      }
      if (col == n + 1 || row == n + 1 || diag == n + 1 || rdiag == n + 1) {
        print('$player won');

        int won = 1;
        if (row == n + 1) {
          for (int i = 0; i < board.length; i++) {
            colorBoard[i][y] = Colors.lightGreen;
          }
          return true;
        }

        else if (col == n + 1) {
          for (int i = 0; i < board.length; i++) {
            colorBoard[x][i] = Colors.lightGreen;
          }
        }

        else if (diag == n + 1) {
          for (int i = 0; i < board.length; i++) {
            colorBoard[i][i] = Colors.lightGreen;
          }
        }

        else if (rdiag == n + 1) {
          for (int i = 0; i < board.length; i++) {
            colorBoard[i][n - i] = Colors.lightGreen;
          }
        }
      }
    }
    }
  }


