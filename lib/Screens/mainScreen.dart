import 'package:flutter/material.dart';
import '../Widgets/tile.dart';

class MainScreen extends StatelessWidget {
  static String name='mainScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            height: MediaQuery.of(context).size.width,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) => Tile(index),
            ),
          ),
        ],
      ),
    );
  }
}
