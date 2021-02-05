import 'package:TicTacToe/Providers/myProvider.dart';
import 'package:flutter/material.dart';
import './mainScreen.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  static String name = 'MenuScreen';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  //final List<String> gameModes = ['classique', 'autre'];
  List<bool> _players = [true, false];
  List<bool> _difficulties = [true, false, false];
  var _diffColor = Colors.green[900];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Tic Tac Toe',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
            Spacer(),
            LayoutBuilder(
              builder: (context, constraints) => ToggleButtons(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person),
                        Text(
                          'One Player',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 45,
                          child: Stack(
                            children: [
                              Icon(Icons.person),
                              Positioned(
                                left: 15,
                                child: Icon(Icons.person),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Two Players',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
                isSelected: _players,
                borderWidth: 3,
                borderRadius: BorderRadius.circular(10),
                selectedBorderColor: Colors.red,
                selectedColor: Colors.red,
                onPressed: (index) {
                  setState(() {
                    _players[0] = !_players[0];
                    _players[1] = !_players[1];
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) => ToggleButtons(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.32,
                    child: Text('Easy', textAlign: TextAlign.center),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.32,
                    child: Text('Medium', textAlign: TextAlign.center),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.32,
                    child: Text('Impossible', textAlign: TextAlign.center),
                  ),
                ],
                isSelected: _difficulties,
                borderWidth: 3,
                borderRadius: BorderRadius.circular(10),
                selectedBorderColor: _diffColor,
                selectedColor: Colors.black,
                onPressed: _players[1]
                    ? null
                    : (index) {
                        setState(() {
                          for (var i = 0; i < 3; i++) {
                            if (i == index)
                              _difficulties[i] = true;
                            else
                              _difficulties[i] = false;
                          }
                          _diffColor = index == 0
                              ? Colors.green[900]
                              : index == 1
                                  ? Colors.yellow
                                  : Colors.red;
                        });
                      },
              ),
            ),
            Spacer(),
            RaisedButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: double.infinity,
                  child: Text(
                    'New Game',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                onPressed: () {
                  if (_players[1]) {
                    context.read<MyProvider>().computer = Computer.none;
                  } else if (_difficulties[0]) {
                    context.read<MyProvider>().computer = Computer.easy;
                  } else if (_difficulties[1]) {
                    context.read<MyProvider>().computer = Computer.medium;
                  } else if (_difficulties[2]) {
                    context.read<MyProvider>().computer = Computer.impossible;
                  }
                  Navigator.pushNamed(context, MainScreen.name);
                }),
          ],
        ),
      ),
    );
  }
}
