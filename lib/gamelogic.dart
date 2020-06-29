
enum token {
  x,
  o,
}

int computerScore = 0;
int playerScore = 0;
token currentPlayer = token.x;
bool isEnd = false;
bool scoreUpdated = false;
bool isPlaying = false;
List<List<token>> board = [
  [null, null, null],
  [null, null, null],
  [null, null, null]
];

// initial list of colors assigned to boxes on board
List<List<bool>> colorBoard = [
  [false, false, false],
  [false, false, false],
  [false, false, false]
];

bool legitMove(token t) {
  return t == null && !winnerCheck(board, currentPlayer);
}

//changePlayer(token player) {
//  if (player == token.x) {
//    currentPlayer = token.o;
//  } else if (player == token.o) {
//    currentPlayer = token.x;
//  }
//}
//
//void changePlayerIfGameNotOver() {
//  if (!winnerCheck(board)&& !fullBoard(board)){
//    changePlayer(currentPlayer);
//  }
//}

void updateScore(token currentPlayer) {
  if (scoreUpdated == false) {
    scoreUpdated = true;
    isEnd
        ? currentPlayer == token.x ? playerScore++ : computerScore++
        : isEnd = false;
  }
}

void gameReset() {
  board = [
    [null, null, null],
    [null, null, null],
    [null, null, null]
  ];
  colorBoard = [
    [false, false, false],
    [false, false, false],
    [false, false, false]
  ];
  currentPlayer = token.x;
  isEnd = true;

  scoreUpdated = false;
}

bool fullBoard(List<List<token>> board) {
  return board.every((List row) => row.every((cell) => (cell != null)));
  // for (int i = 0; i < 3; i++) {
//    for (int j = 0; j < 3; j++) {
//      if (board[i][j] == null) {
//        return false;
//      }
//    }
//  }
//  return true;
}

bool winnerCheck(List<List<token>> board, token currentPlayer) {

  for (int i = 0; i < 3; i++) {
    if (board[i][0] == currentPlayer &&
        board[i][1] == currentPlayer &&
        board[i][2] == currentPlayer) {
      colorBoard[i][0] = true;
      colorBoard[i][1] = true;
      colorBoard[i][2] = true;
      updateScore(currentPlayer);

      return true;
    }
    if (board[0][i] == currentPlayer &&
        board[1][i] == currentPlayer &&
        board[2][i] == currentPlayer) {
      colorBoard[0][i] = true;
      colorBoard[1][i] = true;
      colorBoard[2][i] = true;
      updateScore(currentPlayer);

      return true;
    }
  }
  if (board[0][0] == currentPlayer &&
      board[1][1] == currentPlayer &&
      board[2][2] == currentPlayer) {
    colorBoard[0][0] = true;
    colorBoard[1][1] = true;
    colorBoard[2][2] = true;
    updateScore(currentPlayer);
    return true;
  }

  if (board[0][2] == currentPlayer &&
      board[1][1] == currentPlayer &&
      board[2][0] == currentPlayer) {
    colorBoard[0][2] = true;
    colorBoard[1][1] = true;
    colorBoard[2][0] = true;
    updateScore(currentPlayer);

    return true;
  }

  else return false;
}

String getCurrentStatus(List<List<token>> board) {
  if (winnerCheck(board, currentPlayer) && currentPlayer == token.x) {
    return 'Player x won';
  } else if (winnerCheck(board, currentPlayer) && currentPlayer == token.o) {
    return 'Computer won';
  } else if (currentPlayer == token.x && !fullBoard(board)) {
    return 'Player x move';
  } else if (currentPlayer == token.o && !fullBoard(board)) {
    return 'Computer move';
  } else if (fullBoard(board)) {
    return 'Draw';
  }
}

//int aiMove(List<List<int>> board, int row, int col) {
//  List<List<dynamic>> copyBoard = board;
//      updateBoard(row, col);
//      if (winnerCheck(copyBoard, currentPlayer) && legitMove(currentPlayer)){
//        return 2;
//  }
//  return 1;
//}

int scorePredictor() {
  //TODO Im[lement the AI
//  if(){
//
//  }
}

