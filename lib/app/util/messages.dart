import 'package:flutter/material.dart';

class Message {
  static void showMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black87,
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 19),
        ),
      ),
    );
  }

  static void showError(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black87,
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red, fontSize: 19),
        ),
      ),
    );
  }
}
