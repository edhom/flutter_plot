import 'package:charts_flutter/flutter.dart';
import 'package:flutter_plot/user_function.dart';
import 'package:math_expressions/math_expressions.dart';

class SeriesCreater {

  ContextModel cm = ContextModel();

  // Calculate y for f(x)
  double calcY(Expression f, double x) {
    cm.bindVariable(Variable('x'), Number(x));
    return f.evaluate(EvaluationType.REAL, cm);
  }

  // Create List of n Series for n UserFunctions
  List<Series<double, double>> create(List<UserFunction> userFunction, double lowerBound, double upperBound) {

    // Get 30 x values across the range
    double step = (upperBound - lowerBound) / 30;
    List<double> range = [for (var i = lowerBound; i <= upperBound; i += step) i];

    // Map every user function to a Series
    return userFunction.map(
      (userFunction) =>
        Series<double, double>(
          id: userFunction.f.toString(),
          // Take custom color
          colorFn: (_, __) => ColorUtil.fromDartColor(userFunction.color),
          // X Values
          domainFn: (double x, _) => x,
          // Y Values
          measureFn: (double x, _) => calcY(userFunction.f, x),
          // Take range as x values
          data: range,
        )
      ).toList();
     

  }

}