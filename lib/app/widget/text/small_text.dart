import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color? textColor;
  final String text;
  final double size;
  final double height;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;

  const SmallText({super.key,
    this.textColor=Colors.grey,
    required this.text,
    this.height = 1.5,
    this.size = 15,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {

    final color = textColor ?? Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey;

    return Text(
      text,
      maxLines: 5,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }
}

