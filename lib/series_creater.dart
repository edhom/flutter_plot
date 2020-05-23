import 'package:charts_flutter/flutter.dart';
import 'package:flutter_plot/color_provider.dart';
import 'package:flutter_plot/user_function.dart';
import 'package:math_expressions/math_expressions.dart';

class SeriesCreater {

  ContextModel _cm = ContextModel();
  ColorProvider _colorProvider = ColorProvider();

  // Calculate y for f(x)
  double calcY(Expression f, double x) {
    _cm.bindVariable(Variable('x'), Number(x));
    return f.evaluate(EvaluationType.REAL, _cm);
  }

  // Create List of n Series for n UserFunctions
  List<Series<double, double>> create(List<UserFunction> userFunctions, double lowerBound, double upperBound) {

    // Get 30 x values across the range
    double step = (upperBound - lowerBound) / 30;
    List<double> range = [for (var i = lowerBound; i <= upperBound; i += step) i];

    // Map every user function to a Series
     return userFunctions.map(
      (userFunction) => 
        Series<double, double>(
          id: userFunction.fExp.toString(),
          // Take custom color
          colorFn: (_, __) => ColorUtil.fromDartColor(userFunction.color),
          // X Values
          domainFn: (double x, _) => x,
          // Y Values
          measureFn: (double x, _) => calcY(userFunction.fExp, x),
          // Take range as x values
          data: range,
        )
      ).toList();

  }

}