import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final Icon? icon;
  final VoidCallback onPressed;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onPressed,
    this.icon,
    this.width = double.infinity,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: onPressed,
      color: color,
      minWidth: width,
      height: height,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        if(icon != null)...[
          icon!,
          const SizedBox(width: 20),
        ],
        Text(text, style: TextStyle(color: textColor, fontSize: 16),)
      ],),
    );
  }
}