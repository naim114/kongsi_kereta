import 'package:flutter/material.dart';

Widget customButton({
  required Widget child,
  required void Function() onPressed,
}) =>
    ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        minimumSize: WidgetStateProperty.all(const Size(
          double.infinity,
          55,
        )),
        backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
        textStyle:
            WidgetStateProperty.all(const TextStyle(color: Colors.white)),
      ),
      child: child,
    );
