import 'package:flutter/material.dart';
import 'package:flutter_plot/graph.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter_plot/series_creater.dart';
import 'package:flutter_plot/user_function.dart';
import 'package:math_expressions/math_expressions.dart';


class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<UserFunction> functions = [];

  SeriesCreater seriesCreater = SeriesCreater();
  List<Series<double, double>> seriesList;

  @override
  void initState() {
    super.initState();
    Parser p = Parser();
    functions.add(UserFunction(p.parse('x^2'), Color.fromHex(code: '#FFAA00')));
    functions.add(UserFunction(p.parse('x^3'), Color.fromHex(code: '#00AAFF')));
    seriesList = seriesCreater.create(functions, -3, 3);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      body: Center(
        child: Graph(seriesList),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),

    );
  }
}