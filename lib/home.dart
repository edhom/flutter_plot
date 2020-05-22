import 'package:charts_flutter/flutter.dart' as Charts;
import 'package:flutter/material.dart';
import 'package:flutter_plot/func_list_tile.dart';
import 'package:flutter_plot/graph.dart';
import 'package:flutter_plot/series_creater.dart';
import 'package:flutter_plot/user_function.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<UserFunction> functions = [];

  SeriesCreater seriesCreater = SeriesCreater();
  List<Charts.Series<double, double>> seriesList;

  @override
  void initState() {
    super.initState();
    Parser p = Parser();
    functions.add(UserFunction(p.parse('x^2'), Colors.orange[500], true));
    functions.add(UserFunction(p.parse('x^3'), Colors.blue[500], true));
    seriesList = seriesCreater.create(functions, -3, 3);
  }

  @override
  Widget build(BuildContext context) {

    BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(50.0),
    topRight: Radius.circular(50.0),
    );

    return Scaffold(
      
      body: SlidingUpPanel(
        defaultPanelState: PanelState.OPEN,
        borderRadius: radius,
        panel: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  'Funktionen', 
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: functions.length,
                itemBuilder: (context, i) {
                  return FuncListTile(functions[i]);
                },
              )
            ],
          ),
        ),
        body: Center(
          child: Graph(seriesList),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),

    );
  }
}