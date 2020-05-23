import 'package:charts_flutter/flutter.dart';

import 'package:flutter_plot/services/math_utils.dart';
import 'package:flutter_plot/model/user_function.dart';

class SeriesCreater {

  // Service for math related methods
  MathUtils mathUtils = MathUtils();

  // Create List of n Series for n UserFunctions
  List<Series<double, double>> create(List<UserFunction> userFunctions, double lowerBound, double upperBound) {

    // Get 40 x values across the range
    double step = (upperBound - lowerBound) / 40;
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
          measureFn: (double x, _) => mathUtils.calcY(userFunction.fExp, x),
          // Take range as x values
          data: range,
        )
      ).toList();

  }

}