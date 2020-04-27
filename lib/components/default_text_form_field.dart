
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final int maxLines;
  final int minLines;
  final TextInputType keyboardType;
  final String helperText;
  final String suffixText;
  const DefaultTextFormField({
    this.labelText,
    this.obscureText = false,
    this.keyboardType,
    this.minLines = 1,
    this.maxLines = 1,
    this.helperText,
    this.suffixText,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        helperText: helperText,
        suffixText: suffixText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
