import 'package:flutter/material.dart';

class MyAlertDialogBox {
  static void showMyAlertDialog(
      BuildContext context,
      String title,
      String message, {
        String? negativeButtonText,
        VoidCallback? onNegativeButtonClick,
        String? positiveButtonText,
        VoidCallback? onPositiveButtonClick,
        Color? negativeButtonColor,
        Color? positiveButtonColor,
      }) {
    showDialog(
      context: context,
      barrierDismissible: false, // Disables dismissal by tapping outside
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Disables back press
          child: AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[

              if (negativeButtonText != null)
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: negativeButtonColor ?? Colors.red, // Default color is red
                  ),
                  child: Text(
                    negativeButtonText,
                    style: TextStyle(color: negativeButtonColor ?? Colors.red),
                  ),
                  onPressed: () {
                    if (onNegativeButtonClick != null) {
                      onNegativeButtonClick();
                    }
                    Navigator.of(context).pop();
                  },
                ),
                if (positiveButtonText != null)
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: positiveButtonColor ?? Colors.blue, // Default color is blue
                  ),
                  child: Text(positiveButtonText),
                  onPressed: () {
                    if (onPositiveButtonClick != null) {
                      onPositiveButtonClick();
                    }
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
