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
  final FormFieldSetter<String> onChanged;
  final FormFieldValidator<String> validator;
  const DefaultTextFormField({
    this.onChanged,
    this.labelText,
    this.obscureText = false,
    this.keyboardType,
    this.minLines = 1,
    this.maxLines = 1,
    this.helperText,
    this.suffixText,
    this.validator,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
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
