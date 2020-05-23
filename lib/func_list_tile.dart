import 'package:flutter/material.dart';
import 'package:flutter_plot/user_function.dart';

class FuncListTile extends StatelessWidget {
  final UserFunction function;
  final Function delete;
  final Function edit;
  final Function toggleShow;
  
  const FuncListTile(this.function, this.delete, this.edit, this.toggleShow);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
        leading: Checkbox(
          value: function.active,
          tristate: true,
          onChanged: (bool value) => toggleShow(),
          activeColor: function.color,
        ),
        title: Text(
          function.fString,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: function.active ? function.color: Colors.black54,
          )
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: delete,
        ),
        onTap: edit,
      ),
    );
  }
}