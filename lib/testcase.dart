import 'package:flutter/material.dart';
import "package:flutter_test/flutter_test.dart";
import 'package:tic_tac_toe_starter/gamelogic.dart';

void main() {
  test("test fullBoard", () {
    List<List<Icon>> board = [
      [null, null, null],
      [null, null, null],
      [null, null, null]
    ];

    board[2][2] = xIcon;
    print(board);

    expect(fullBoard(board), false);

  });

}