import 'package:charts_flutter/flutter.dart' as Charts;
import 'package:flutter/material.dart';
import 'package:flutter_plot/color_provider.dart';
import 'package:flutter_plot/input_dialog.dart';
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
  
  Parser parser = Parser();
  ColorProvider colorProvider = ColorProvider();
  List<UserFunction> functions = [];

  SeriesCreater seriesCreater = SeriesCreater();
  List<Charts.Series<double, double>> seriesList;

  void addFunc(String input) {
    Expression exp = parser.parse(input);
    UserFunction newFunc = UserFunction(
      input, exp, colorProvider.getColor(), true
    );
    setState(() {
      functions.add(newFunc);
      updatePlot();
    });
  }

  void showAddDialog() {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return InputDialog(addFunc, parser);
      });
  }

  void editFunc(String input, int index) {
    Expression exp = parser.parse(input);
    setState(() {
      functions[index].fString = input;
      functions[index].fExp = exp;
      updatePlot();
    });
  }

  void showEditDialog(int index) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return InputDialog((String input) => editFunc(input, index), parser, exp: functions[index].fString);
      });
  }

  void deleteFunc(int index) {
    setState(() {
      functions.removeAt(index);
      updatePlot();
    });
  }

  void toggleShow(int index) {
    setState(() {
      functions[index].active = !functions[index].active;
      updatePlot();
    });
  }

  void updatePlot() {
    List<UserFunction> activeFunctions = functions.where((userFunc) => userFunc.active).toList();
    seriesList = seriesCreater.create(activeFunctions, -3, 3);
  }

  @override
  void initState() {
    super.initState();
    functions.add(UserFunction('x^2', parser.parse('x^2'), colorProvider.getColor(), true));
    updatePlot();
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
                  'Functions', 
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                  shrinkWrap: true,
                  itemCount: functions.length,
                  itemBuilder: (context, i) {
                    return FuncListTile(functions[i], () => deleteFunc(i), () => showEditDialog(i), () => toggleShow(i));
                  },
                ),
              )
            ],
          ),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 15, right: 15, bottom: 120, left: 15),
            child: Graph(seriesList)
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        tooltip: 'New Function',
        child: Icon(Icons.add),
      ),

    );
  }
}