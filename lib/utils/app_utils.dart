import 'package:employee_app/constants/custom_textstyles.dart';
import 'package:flutter/material.dart';

showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: kSnackBarMessageTextStyle,
      ),
    ),
  );
}

showSnackbarWithActions(
    BuildContext context, String message, VoidCallback onTap) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.only(right: 10, left: 16),
      content: Text(
        message,
        style: kSnackBarMessageTextStyle,
      ),
      action: SnackBarAction(
        label: 'Undo',
        textColor: const Color(0xFF1DA1F2),
        onPressed: onTap,
      ),
    ),
  );
}
