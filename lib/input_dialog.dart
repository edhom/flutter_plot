import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class InputDialog extends StatefulWidget {

  final String exp;
  final Parser parser;
  final void Function(String txt) saveFunc;
  InputDialog(this.saveFunc, this.parser, {this.exp = ''});

  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {

  final GlobalKey<FormState> formKey = GlobalKey();
  String input;
  
  void save() {
    if (formKey.currentState.validate()) {
      widget.saveFunc(input);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20),
            TextFormField(
              initialValue: widget.exp,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              onChanged: (String txt) => input = txt,
              onFieldSubmitted: (String txt) => save(),
              validator: (String input) {
                if (input.isEmpty) {
                  return 'Please enter a value';
                }
                try {
                  widget.parser.parse(input);
                } catch(e) {
                  return 'Not a correct expression';
                }
                return null;
              }
            ),
            SizedBox(height: 25),
            RawMaterialButton(
              onPressed: save,
              elevation: 2.0,
              fillColor: Colors.blue[500],
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 35.0,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            ),
          ],
        )
      ),
    );
  }
}