import 'package:flutter/material.dart';
import 'package:flutter_plot/home.dart';

void main() {
  runApp(FunctionPlot());
}

class FunctionPlot extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Function Plot',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }

}