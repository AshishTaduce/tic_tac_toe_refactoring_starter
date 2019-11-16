enum token {
  x,
  o,
}

int computerScore = 0;
int playerScore = 0;
token currentPlayer = token.x;
bool isEnd;

void updateScore(token currentPlayer) {
  isEnd ? currentPlayer == token.x ? playerScore++ : computerScore++
      : isEnd = false;
}

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
  for (int i = 0; i < 3; i++){
    for(int j =0; j < 3; j++){
      if (board[i][0] == currentPlayer &&
          board[i][1] == currentPlayer &&
          board[i][2] == currentPlayer) {
        colorBoard[i][0] = true;
        colorBoard[i][1] = true;
        colorBoard[i][2] = true;
        updateScore(currentPlayer);
        return true;
      }
    }
  }




  for (int i = 0; i < 3; i++) {
    if (board[i][0] == token.x &&
        board[i][1] == token.x &&
        board[i][2] == token.x) {
      colorBoard[i][0] = true;
      colorBoard[i][1] = true;
      colorBoard[i][2] = true;
      playerScore++;
      return true;
    }
    if (board[0][i] == token.x &&
        board[1][i] == token.x &&
        board[2][i] == token.x) {
      colorBoard[0][i] = true;
      colorBoard[1][i] = true;
      colorBoard[2][i] = true;
      playerScore++;
      return true;
    }
    if (board[i][0] == token.o &&
        board[i][1] == token.o &&
        board[i][2] == token.o) {
      colorBoard[i][0] = true;
      colorBoard[i][1] = true;
      colorBoard[i][2] = true;
      return true;
    }
    if (board[0][i] == token.o &&
        board[1][i] == token.o &&
        board[2][i] == token.o) {
      colorBoard[0][i] = true;
      colorBoard[1][i] = true;
      colorBoard[2][i] = true;
      return true;
    }
  }
  if (board[0][0] == token.x &&
      board[1][1] == token.x &&
      board[2][2] == token.x) {
    colorBoard[0][0] = true;
    colorBoard[1][1] = true;
    colorBoard[2][2] = true;
    return true;
  }
  if (board[0][2] == token.x &&
      board[1][1] == token.x &&
      board[2][0] == token.x) {
    colorBoard[0][2] = true;
    colorBoard[1][1] = true;
    colorBoard[2][0] = true;
    return true;
  }
  if (board[0][0] == token.o &&
      board[1][1] == token.o &&
      board[2][2] == token.o) {
    colorBoard[0][0] = true;
    colorBoard[1][1] = true;
    colorBoard[2][2] = true;
    return true;
  }
  if (board[0][2] == token.o &&
      board[1][1] == token.o &&
      board[2][0] == token.o) {
    colorBoard[0][2] = true;
    colorBoard[1][1] = true;
    colorBoard[2][0] = true;
    return true;
  } else {
    return false;
  }
}



String getCurrentStatus(List<List<token>> board){
  if (winnerCheck(board, currentPlayer) && currentPlayer == token.x){
    return 'Player x won';
  }
  else if (winnerCheck(board, currentPlayer) && currentPlayer == token.o){
    return 'Computer won';
  }
  else if (currentPlayer == token.x && !fullBoard(board)){
    return 'Player x move';
  }
  else  if (currentPlayer == token.o && !fullBoard(board)) {
    return 'Computer move';
  }
  else  if (fullBoard(board)){
    return 'Draw';
  }

}

int aiMove(List<List<int>> board){

}

int scorePredictor(){
  //TODO Im[lement the AI
//  if(){
//
//  }
}

