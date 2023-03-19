import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/employee_model.dart';

class AppConst {
  static const Color primaryColor = Colors.amber;
  static const Color secondaryColor = Colors.red;
}

TextStyle boldLargeText =
    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

bool isDate(String input, String format) {
  try {
    final DateTime d = DateFormat(format).parseStrict(input);
    return true;
  } catch (e) {
    return false;
  }
}

Future<dynamic> deleteConfirmationAlertDialog(
    BuildContext context, EmployeeModel employee) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text("Do you want to delete ${employee.employeeName} data"),
        actions: [
          TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              child: const Text("Yes")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("No")),
        ],
      );
    },
  );
}
