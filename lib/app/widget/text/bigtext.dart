import 'package:flutter/material.dart';
class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overflow;
  final FontWeight? fontWeight;
  final TextAlign textAlign;
  final EdgeInsetsGeometry padding;

  BigText({
    super.key,
    this.color,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 22,
    this.fontWeight = FontWeight.w700,
    this.textAlign = TextAlign.left,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {

    final textColor = color ?? Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF332d2d);

    return Padding(
      padding: padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Text(
            text,
            softWrap: true,
            maxLines: 3,
            overflow: overflow,
            textAlign: textAlign,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: textColor,
              fontSize: size,
              fontWeight: fontWeight,
            ),
          );
        },
      ),
    );
  }
}