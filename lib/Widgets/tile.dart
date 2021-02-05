import 'package:TicTacToe/Screens/menuScreen.dart';
import '../Screens/mainScreen.dart';

import '../Providers/myProvider.dart';
import 'package:flutter/material.dart';
import 'package:TicTacToe/constants.dart';
import 'package:provider/provider.dart';

class Tile extends StatefulWidget {
  int row;
  int col;

  Tile(int index) {
    row = (index / 3).floor();
    col = index % 3;
  }

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    var value = context.watch<MyProvider>().value(widget.row, widget.col);
    if (value == 0) {
      return GestureDetector(
        onTap: () {
          context.read<MyProvider>().changeBoard(widget.row, widget.col);
          var result = context.read<MyProvider>().result;
          if (result != 0) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text((result == 1 || result == -1)
                      ? 'Player ${result == 1 ? 2 : 1} won !'
                      : 'It\'s a draw'),
                  actions: [
                    TextButton(
                      child: Text('Main Menu'),
                      onPressed: () {
                        context.read<MyProvider>().resetBoard();
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName(MenuScreen.name));
                      },
                    ),
                    TextButton(
                      child: Text('New Game'),
                      onPressed: () {
                        context.read<MyProvider>().resetBoard();
                        Navigator.of(context).popUntil(ModalRoute.withName(MainScreen.name));
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: GridTile(
          child: Container(color: Theme.of(context).primaryColor),
        ),
      );
    }
    return GridTile(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: FittedBox(
          child: Icon(
            value == 1 ? firstIcon : secondIcon,
            color: value == 1 ? firstIconColor : secondIconColor,
          ),
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
