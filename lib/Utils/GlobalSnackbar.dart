import 'package:flutter/material.dart';

class GlobalSnackbar {
  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  static void showWarning(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: Colors.orange,
      textColor: Colors.black,
    );
  }

  static void showError(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  static void _showSnackBar(
      BuildContext context,
      String message, {
        required Color backgroundColor,
        required Color textColor,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}