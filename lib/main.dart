import 'package:deadsimplecovid/screens/loading_screen.dart';
import 'package:flutter/material.dart';

//when our app is run, the starting file is main.dart.  The app looks for main, similar to C programming
void main() {
  runApp(
    CovidPage(),
  );
}

class CovidPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: LoadingScreen(),
    );
  }
}
