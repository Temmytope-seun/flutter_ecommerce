import 'package:flutter/material.dart';

// ignore: must_be_immutable
class kSignButton extends StatelessWidget {
  kSignButton({this.value, this.onPressed, this.alternative, this.route});

  String value;
  String alternative;
  Function onPressed;
  Function route;
  bool _isSubmitting = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          _isSubmitting == true ? CircularProgressIndicator() : RaisedButton(
            child: Text(value, style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Colors.black
            )),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            color: Theme.of(context).primaryColor,
            onPressed: onPressed,
          ),
          FlatButton(
            child: Text(alternative),
            onPressed: route,
          )
        ],
      ),
    );
  }
}