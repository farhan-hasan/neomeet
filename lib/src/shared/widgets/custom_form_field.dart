import 'package:flutter/material.dart';
import 'package:neomeet/src/core/utils/extension/context_extension.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.obscureText = false,
    this.helperText,
  });

  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.08,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          helperText: helperText,
          // prefixIcon: IconButton(onPressed: onPressed, icon: icon),
          border: OutlineInputBorder(),
        ),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
