import 'dart:math';

List<List<List<int>>> availablePositions(
    List<List<int>> board, bool maximizingPlayer) {
  var positions = <List<List<int>>>[];
  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      if (board[i][j] == 0) {
        //var temp1=[...board];
        var temp1 =
            List.generate(3, (i) => List.generate(3, (j) => board[i][j]));
        //var temp1=List.unmodifiable(board);
        //print(temp1);
        //print(board);
        temp1[i][j] = maximizingPlayer ? 1 : -1; //a voir si 1 et 2 est ok
        positions.add(temp1);
      }
    }
  }
  return positions;
}

double posEval(List<List<int>> pos) {
  //print(pos);
  for (var i = 0; i < 3; i++) {
    if ((pos[i][0] == pos[i][1]) &&
        (pos[i][1] != 0) &&
        (pos[i][1] == pos[i][2])) {
      return pos[i][1].toDouble();
    }
    if ((pos[0][i] == pos[1][i]) &&
        (pos[1][i] != 0) &&
        (pos[1][i] == pos[2][i])) {
      return pos[1][i].toDouble();
    }
  }
  if ((pos[0][0] == pos[1][1]) &&
      (pos[1][1] != 0) &&
      (pos[1][1] == pos[2][2])) {
    return pos[1][1].toDouble();
  }
  if ((pos[0][2] == pos[1][1]) &&
      (pos[1][1] != 0) &&
      (pos[1][1] == pos[2][0])) {
    return pos[1][1].toDouble();
  }
  if (checkDraw(pos)) return 0;

  //-10 means the game is not finished
  return -10;
}

bool checkDraw(var pos) {
  for (var row in pos) {
    if (row.contains(0)) {
      return false;
    }
  }
  return true;
}

int bestMove(List<List<int>> board, bool maximizingPlayer) {
  var moves = availablePositions(board, maximizingPlayer);
  var bestScore = maximizingPlayer ? double.negativeInfinity : double.infinity;
  var bestIndex = 0;
  for (var i = 0; i < moves.length; i++) {
    var score = minimax(moves[i], 10, !maximizingPlayer);
    print(moves[i]);
    print(score);
    print('---------------------------------------------');

    if (maximizingPlayer && (score > bestScore)) {
      bestIndex = i;
      bestScore = score;
    } else if ((!maximizingPlayer) && (bestScore > score)) {
      bestIndex = i;
      bestScore = score;
    }
  }

  return bestIndex;
}

List<int> freeSquares(List<List<int>> pos) {
  var free = <int>[];
  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      if (pos[i][j] == 0) {
        free.add(3 * i + j);
      }
    }
  }
  return free;
}

double minimax(List<List<int>> board, int depth, bool maximizingPlayer) {
  var staticEval = posEval(board);
  if (depth == 0 || staticEval != -10) {
    return staticEval;
  }
  if (maximizingPlayer) {
    var maxEval = double.negativeInfinity;
    for (var pos in availablePositions(board, true)) {
      var eval = minimax(pos, depth - 1, false);
      maxEval = max(maxEval, eval);
    }
    return maxEval;
  } else {
    var minEval = double.infinity;
    for (var pos in availablePositions(board, false)) {
      var eval = minimax(pos, depth - 1, true);
      minEval = min(minEval, eval);
    }
    return minEval;
  }
}

void main() {
  print('ok');
  print(bestMove([
    [1, 0, -1],
    [0, 0, 0],
    [-1, 0, 1]
  ], false));
}
