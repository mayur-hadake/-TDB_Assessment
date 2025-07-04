import 'package:flutter/material.dart';

class ProgressDialog {
  static void show(BuildContext context) {
    debugPrint("Display Progress Dialog");
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent outside touch dismissal
      builder: (context) => WillPopScope(
        onWillPop: () async => false, // Disable back button
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Please wait..."),
            ],
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}