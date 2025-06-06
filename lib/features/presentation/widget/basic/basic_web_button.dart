import 'package:flutter/material.dart';

class BasicWebButton extends StatelessWidget{
  final VoidCallback? onPressed;
  final String title;
  final double ? height;
  final double ? width;
  final Color ? backgroundColor;
  final Color ? textColor;
  final double ? fontSize;
  const BasicWebButton({
    required this.onPressed,
    this.title = '',
    this.height,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    super.key
  });

   @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF76C919),
          minimumSize: Size(
            width ?? MediaQuery.of(context).size.width,
            height ?? 60
          ),
        ),
        child: Text(
            title,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? 20,
              letterSpacing: fontSize==null ? 4: fontSize!*0.2
           ),
         )
      );
  }
}