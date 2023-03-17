import 'package:flutter/material.dart';

import '../main.dart';

class ShowMsgUtils {
  static showsnackBar({required String title, Color color = Colors.green}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).clearSnackBars();

      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: color,
          content: Text(title)));
    });
  }

  static clearSnackBar() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).clearSnackBars();
    });
  }
}
