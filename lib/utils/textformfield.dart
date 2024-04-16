import 'package:flutter/material.dart';

class TffFormat extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  const TffFormat({
    required this.hintText,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 20,
          color: Colors.green),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(5.0),
        hintText: hintText,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 1.0,
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}