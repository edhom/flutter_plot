import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class UserFunction {
  
  // Function as String, since toString() adds Parantheses around. 
  String fString;
  
  // Function as math_expressions Expression
  Expression fExp;
  
  // Own function color
  Color color;
  
  // Flag to show or hide
  bool active;

  UserFunction(this.fString, this.fExp, this.color, this.active);
}