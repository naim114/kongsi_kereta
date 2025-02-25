import 'package:flutter/material.dart';

Widget customPillButton({
  required BuildContext context,
  required Color borderColor,
  Color fillColor = Colors.deepPurple,
  required void Function()? onPressed,
  required Widget child,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        color: fillColor,
      ),
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
