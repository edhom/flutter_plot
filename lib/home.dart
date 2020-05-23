import 'package:charts_flutter/flutter.dart' as Charts;
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:flutter_plot/services/color_provider.dart';
import 'package:flutter_plot/input_dialog.dart';
import 'package:flutter_plot/func_list_tile.dart';
import 'package:flutter_plot/graph.dart';
import 'package:flutter_plot/services/math_utils.dart';
import 'package:flutter_plot/services/series_creater.dart';
import 'package:flutter_plot/model/user_function.dart';



class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  // Parser for Math expressions
  Parser parser = Parser();

  // Service for math related methods
  MathUtils mathUtils = MathUtils();

  // Service for easy color assigning
  ColorProvider colorProvider = ColorProvider();

  // Service for creating plot data
  SeriesCreater seriesCreater = SeriesCreater();

  // List with all User Functions
  List<UserFunction> functions = [];

  // Plot data
  List<Charts.Series<double, double>> seriesList;
  
  // Optional tanget function
  UserFunction tangent;

  // Add new function 
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

  // Update function at index
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

  // Delete function at index
  void deleteFunc(int index) {
    setState(() {
      functions.removeAt(index);
      updatePlot();
    });
  }

  // Show or hide function at index
  void toggleShow(int index) {
    setState(() {
      functions[index].active = !functions[index].active;
      updatePlot();
    });
  }

  // Update Plot Data and add tangent if available
  void updatePlot() {
    List<UserFunction> activeFunctions = functions.where((userFunc) => userFunc.active).toList();
    if (tangent != null) {
      activeFunctions.add(tangent);
    }
    seriesList = seriesCreater.create(activeFunctions, -3, 3);
  }

  // On selection, calculate tangent and set var 
  void showTangente(Charts.SelectionModel<num> model) {
    String funcID = model.selectedSeries.first.id;
    num xVal = model.selectedDatum.first.datum;
    tangent = mathUtils.getTangente(funcID, xVal);
    setState(() {
      updatePlot();
    });
  }

  // Add Demo Function on start up
  @override
  void initState() {
    super.initState();
    functions.add(UserFunction('x^2', parser.parse('x^2'), colorProvider.getColor(), true));
    updatePlot();
  }

  @override
  Widget build(BuildContext context) {

    // Border Radius for Bottom Sheet
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
              
              // Header
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

              // List View with Functions
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

        // Actual Graph
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 15, right: 15, bottom: 120, left: 15),
            child: Graph(seriesList, showTangente)
          ),
        ),
      ),
      
      // Add Button
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        tooltip: 'New Function',
        child: Icon(Icons.add),
      ),

    );
  }
}