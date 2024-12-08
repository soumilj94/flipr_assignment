import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextInputType type;
  final bool visibility;
  final TextEditingController? controller;
  const CustomInputField({
    super.key,
    required this.type,
    this.visibility = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      obscureText: visibility,
      controller: controller,
      autocorrect: false,
      decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.deepOrangeAccent,
                width: 2,
              )),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          )
      ),);
  }
}