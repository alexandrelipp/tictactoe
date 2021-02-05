import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import '../Ai/minMax.dart';

enum Computer {
  none,
  easy,
  medium,
  impossible,
}

class MyProvider with ChangeNotifier {
  Computer _computer = Computer.none;
  bool _isFirstTurn = false;

  int _result = 0;
  List<List<int>> _board = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0]
  ];
  set computer(Computer computer) {
    _computer = computer;
  }

  int get result {
    return _result;
  }

  int value(int row, int col) {
    return _board[row][col];
  }

  void resetBoard() {
    _board = [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ];
    _result = 0;
    _isFirstTurn = false;
    notifyListeners();
  }

  bool checkWin() {
    for (int i = 0; i < 3; i++) {
      if ((_board[i][0] == _board[i][1]) &&
          (_board[i][1] != 0) &&
          (_board[i][1] == _board[i][2])) {
        _result = _board[i][1];

        return true;
      }
      if ((_board[0][i] == _board[1][i]) &&
          (_board[1][i] != 0) &&
          (_board[1][i] == _board[2][i])) {
        _result = _board[1][i];

        return true;
      }
    }
    if ((_board[0][0] == _board[1][1]) &&
        (_board[1][1] != 0) &&
        (_board[1][1] == _board[2][2])) {
      _result = _board[1][1];

      return true;
    }
    if ((_board[0][2] == _board[1][1]) &&
        (_board[1][1] != 0) &&
        (_board[1][1] == _board[2][0])) {
      _result = _board[1][1];

      return true;
    }

    return false;
  }

  bool checkDraw() {
    for (var row in _board) {
      if (row.contains(0)) {
        return false;
      }
    }
    _result = 3;
    return true;
  }

  int bestPos() {
    var free = freeSquares();
    if (_computer == Computer.easy ||
        (_computer == Computer.medium && Random().nextInt(10) < 4)) {
      return free[Random().nextInt(free.length)];
    }
    var bestIndex = bestMove(_board, true);
    return free[bestIndex];
  }

  void _computerMove(int row, int col) {
    var aiPos = bestPos();
    var row = (aiPos / 3).floor();
    var col = aiPos % 3;
    _board[row][col] = _isFirstTurn ? 1 : -1;
    notifyListeners();
    if (checkWin()) return;
    if (checkDraw()) return;
    _isFirstTurn = !_isFirstTurn;
  }

  void changeBoard(int row, int col) {
    if (_board[row][col] == 0) {
      _board[row][col] = _isFirstTurn ? 1 : -1;
      notifyListeners();
      if (checkWin()) return;
      if (checkDraw()) return;
      _isFirstTurn = !_isFirstTurn;
      if (_computer != Computer.none) {
        _computerMove(row, col);
      }
    }
  }

  List<int> freeSquares() {
    List<int> free = [];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == 0) {
          free.add(3 * i + j);
        }
      }
    }
    return free;
  }
}
