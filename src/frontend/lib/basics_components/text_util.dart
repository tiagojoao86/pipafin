import 'package:flutter/material.dart';

class TextUtil extends StatelessWidget {
  const TextUtil(value, {super.key, foreground, textSize}) :
    text = value ?? '',
    color = foreground ?? Colors.black,
    size = textSize ?? 14.0,
    weight = FontWeight.normal;

  const TextUtil.title(value, {super.key, foreground, textSize}) :
    text = value ?? '',
    color = foreground ?? Colors.white,
    size = textSize ?? 28.0,
    weight = FontWeight.bold;

  const TextUtil.subTitle(value, {super.key, foreground, textSize}) :
    text = value ?? '',
    color = foreground ?? Colors.white,
    size = textSize ?? 24.0,
    weight = FontWeight.bold;

  const TextUtil.label(value, {super.key, foreground, textSize}) :
    text = value ?? '',
    color = foreground ?? Colors.black,
    size = textSize ?? 16.0,
    weight = FontWeight.bold;

  final String text;
  final Color color;
  final double size;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}