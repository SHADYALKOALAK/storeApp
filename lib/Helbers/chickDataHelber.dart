import 'package:flutter/material.dart';

mixin ChickData {
  void showSnackBar(BuildContext context, String massage,Color? color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(massage),
      ),
    );
  }
}
