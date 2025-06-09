import 'package:flutter/material.dart';

class BasicTextfield extends StatelessWidget{
  final TextEditingController controller;
  final double? fontSize;
  final String ? hintText;
  final Color ? borderColor;
  final String ? errorText;
  final Color ? errorBorderColor;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final bool? readOnly;

  const BasicTextfield({
    required this.controller,
    this.fontSize,
    this.hintText,
    this.borderColor,
    this.errorText,
    this.errorBorderColor,
    this.onChanged,
    this.maxLines,
    this.readOnly
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        readOnly: readOnly ?? false,
        controller: controller,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor ?? Colors.black)
          ),
          hintText:  hintText,
          errorText: errorText,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorBorderColor ?? Color(0xFFF96D4E))
          )
        ),
        onChanged: onChanged,
    );
  }
}