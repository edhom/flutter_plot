import 'package:flutter/material.dart';
import 'package:flutter_plot/user_function.dart';
import 'package:math_expressions/math_expressions.dart';

class MathUtils {

  ContextModel _cm = ContextModel();
  Parser parser = Parser();

  // Calculate y for f(x)
  double calcY(Expression f, double x) {
    _cm.bindVariable(Variable('x'), Number(x));
    return f.evaluate(EvaluationType.REAL, _cm);
  }

  // Calculate tangent equation
  UserFunction getTangente(String exp, num xVal) {
    Expression f = parser.parse(exp);
    Expression df = f.derive('x').simplify();
    Number m = Number(calcY(df, xVal));
    Number b = Number(calcY(f, xVal));
    Number diff = Number(xVal);
    Variable x = Variable('x');
    Expression tang = m*(x-diff)+b;
    return UserFunction(tang.toString(), tang, Colors.grey, true);
  }


}