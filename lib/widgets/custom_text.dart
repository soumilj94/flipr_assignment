import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final Alignment alignment;

  const CustomTextWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Align(alignment: alignment,
      child: Text(text, style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),),
    );
  }
}