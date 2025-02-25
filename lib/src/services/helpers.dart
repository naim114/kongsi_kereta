import 'package:flutter/material.dart';
import 'package:theme_mode_handler/theme_picker_dialog.dart';

class CustomColor {
  static const primary = Color(0xFF643FDB);
  static const secondary = Color(0xFFFF8A00);
  static const neutral1 = Color(0xFF1C1243);
  static const neutral2 = Color(0xFFA29EB6);
  static const neutral3 = Color(0xFFEFF1F3);
  static const danger = Color(0xFFFE4A49);
  static const success = Color(0xFF47C272);
}

bool isDarkTheme(context) {
  return Theme.of(context).brightness == Brightness.dark ? true : false;
}

Color getColorByBackground(context) {
  return isDarkTheme(context) ? Colors.white : CustomColor.neutral1;
}

void selectThemeMode(BuildContext context) async {
  final newThemeMode = await showThemePickerDialog(context: context);
  debugPrint(newThemeMode.toString());
}

bool validateEmail(TextEditingController emailController) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return regex.hasMatch(emailController.text);
}

bool validatePassword(TextEditingController passwordController) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  return regex.hasMatch(passwordController.text);
}

extension ListExtension<E> on List<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) {
    return Map.fromEntries(
      groupByMapEntries(keyFunction),
    );
  }

  Iterable<MapEntry<K, List<E>>> groupByMapEntries<K>(
      K Function(E) keyFunction) sync* {
    final groups = <K, List<E>>{};
    for (final element in this) {
      final key = keyFunction(element);
      if (!groups.containsKey(key)) {
        groups[key] = <E>[];
      }
      groups[key]!.add(element);
    }
    yield* groups.entries;
  }
}

String timeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 365) {
    final years = (difference.inDays / 365).floor();
    return '$years year${years > 1 ? "s" : ""} ago';
  } else if (difference.inDays > 30) {
    final months = (difference.inDays / 30).floor();
    return '$months month${months > 1 ? "s" : ""} ago';
  } else if (difference.inDays > 0) {
    final days = difference.inDays;
    return '$days day${days > 1 ? "s" : ""} ago';
  } else if (difference.inHours > 0) {
    final hours = difference.inHours;
    return '$hours hour${hours > 1 ? "s" : ""} ago';
  } else if (difference.inMinutes > 0) {
    final minutes = difference.inMinutes;
    return '$minutes minute${minutes > 1 ? "s" : ""} ago';
  } else if (difference.inSeconds >= 0) {
    final seconds = difference.inSeconds;
    return '$seconds second${seconds > 1 ? "s" : ""} ago';
  } else {
    return 'Just now';
  }
}
