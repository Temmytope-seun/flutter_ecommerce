import 'package:flutter/material.dart';

class kFormField extends StatelessWidget {
  kFormField({this.label, this.hint, this.icon, this.obscure, this.validate, this.onSaved, this.suffix});
  bool obscure;
  String label;
  String hint;
  Icon icon;
  Function validate;
  Function onSaved;
  Widget suffix;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        obscureText: obscure,
        onSaved: onSaved,
        validator: validate,
        decoration: InputDecoration(
          suffixIcon: suffix,
          border: OutlineInputBorder(),
          labelText: label,
          hintText: hint,
          icon: icon,
        ),
      ),);
  }
}