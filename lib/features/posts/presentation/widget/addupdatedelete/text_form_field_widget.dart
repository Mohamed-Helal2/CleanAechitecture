import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      required this.hint,
      required this.controller,
      required this.multilines});
  final String hint;
  final TextEditingController controller;
  final bool multilines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextFormField(
        controller: controller,
        validator: (value) => value!.isEmpty ? "$hint Cant be empty" : null,
        decoration: InputDecoration(hintText: hint),
        maxLines: multilines ? 6 : 1,
        minLines: multilines ? 6 : 1,
      ),
    );
  }
}
