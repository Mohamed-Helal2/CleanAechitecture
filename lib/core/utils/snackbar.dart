import 'package:flutter/material.dart';

class SnackbarMessage {
  void showSnackBar(
      {required BuildContext context, required String message,required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
        backgroundColor: color
      ),
    );
  }
}
