import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text; // Text to display on the button
  final VoidCallback onTap; // Action to be executed when button is tapped
  final Color color; // Background color of the button
  final Color textColor; // Text color
  final double borderRadius; // Border radius for rounded corners
  final EdgeInsets padding;// Padding inside the button
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  const CustomButton({
    super.key,
    this.width=100,
    this.height=60,
    this.margin,
    required this.text,
    required this.onTap,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.all(10),

        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
