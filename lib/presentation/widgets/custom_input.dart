import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        isDense: true,
        border: UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE6ECF8)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF5E83D8), width: 1.5),
        ),
      ),
    );
  }
}
