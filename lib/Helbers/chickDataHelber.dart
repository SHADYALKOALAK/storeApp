import 'package:flutter/material.dart';

mixin ChickData {
  void showSnackBar(BuildContext context, String massage, bool? color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            color == true ? Colors.red : Theme.of(context).primaryColor,
        content: Text(massage),
      ),
    );
  }
}
