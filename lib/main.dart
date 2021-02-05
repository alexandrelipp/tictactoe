import 'package:TicTacToe/Screens/menuScreen.dart';
import 'package:flutter/services.dart';

import './Providers/myProvider.dart';
import 'package:TicTacToe/Screens/mainScreen.dart';
import 'package:TicTacToe/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          MainScreen.name: (context) => MainScreen(),
          MenuScreen.name: (context) => MenuScreen(),
        },
        title: 'Flutter Demo',
        theme: myTheme,
        initialRoute: MenuScreen.name,
      ),
    );
  }
}
