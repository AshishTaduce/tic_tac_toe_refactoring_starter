import "package:flutter_test/flutter_test.dart";
import 'gamelogic.dart';

void main() {
  test(
    "test fullBoard",
    () {
      List<List<token>> board = [
        [null, null, null],
        [null, null, null],
        [null, null, null]
      ];
      board[2][2] = token.x;
      print(board);
      expect(fullBoard(board), false);
    },
  );
  test(
    "test checkgamestaus for change of player",
    () {
      expect(currentPlayer, token.x);
      changePlayerIfGameNotOver();
      expect(currentPlayer, token.o);
    },
  );

  test(
    "test checkgamestaus for change of player",
        () {
      currentPlayer = token.x;

      board = [
        [token.x, token.x, token.o],
        [token.o, token.x, token.x],
        [token.x, token.o, token.x]
      ];

      changePlayerIfGameNotOver();
      expect(currentPlayer, token.o);

    },
  );

  test(
    "get currentstatus",
        () {
      currentPlayer = token.x;
      List<List<token>> x = [
        [token.x, token.x, token.o],
        [token.o, token.x, token.x],
        [token.x, token.o, token.o]
      ];
      expect(getCurrentStatus(x), 'Draw');



    },
  );
}

