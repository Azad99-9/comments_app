import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Key key;
  final String labelText;
  final bool obscureText;
  final String? Function(String?) validator;
  final void Function(String?) onSaved;

  const CustomTextFormField({
    required this.key,
    required this.labelText,
    this.obscureText = false,
    required this.validator,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        key: key,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide.none,
          ),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
