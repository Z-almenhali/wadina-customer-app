import 'package:flutter/material.dart';

void showSnackBar(String title, BuildContext context, Color color) {

  final snackbar = SnackBar(
    duration: Duration(seconds: 3),
    backgroundColor: color,
    content: Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  );

  Scaffold.of(context).showSnackBar(snackbar);
}
