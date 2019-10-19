import 'package:flutter/material.dart';
import "package:flutter_test/flutter_test.dart";

void main() {
  test("test fullBoard", () {
    List<List<Icon>> board = [
      [null, null, null],
      [null, null, null],
      [null, null, null]
    ];

    board[2][2] = Icon(Icons.close);
    print(board);

    //expect(fullBoard(List<List<currentPlayerText>>), false);

  },
  );

}