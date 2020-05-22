import 'package:charts_flutter/flutter.dart';
import 'package:math_expressions/math_expressions.dart';

class SeriesCreater {

  List<Series<double, double>> create(Expression expression, double lowerBound, double upperBound) {

    // Get 30 x Values across the range
    double step = (upperBound - lowerBound) / 30;
    List<double> range = [for (var i = lowerBound; i <= upperBound; i += step) i];

    return [
      Series<double, double>(
          id: '1',
          colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
          domainFn: (double xVal, _) => xVal,
          measureFn: (double xVal, _) {
            ContextModel cm = ContextModel();
            cm.bindVariable(Variable('x'), Number(xVal));
            return expression.evaluate(EvaluationType.REAL, cm);
          },
          data: range,
      )
    ];

  }

}