import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, this.onPressed, required this.isupdated});
  final void Function()? onPressed;
  final bool isupdated;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.blue)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isupdated ? Icons.edit : Icons.add,
            size: 40,
          ),
          Text(isupdated ? "Update" : "Add")
        ],
      ),
    );
  }
}
