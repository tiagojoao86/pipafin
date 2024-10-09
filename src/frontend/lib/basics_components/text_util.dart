import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';

class TextUtil extends StatelessWidget {
  const TextUtil(value, {super.key, foreground, textSize}) :
    text = value ?? '',
    color = foreground ?? DefaultColors.textColor,
    size = textSize ?? DefaultSizes.regularFont,
    weight = FontWeight.normal;

  const TextUtil.title(value, {super.key, foreground, textSize}) :
    text = value ?? '',
    color = foreground ?? DefaultColors.textColor,
    size = textSize ?? DefaultSizes.titleFont,
    weight = FontWeight.bold;

  const TextUtil.subTitle(value, {super.key, foreground, textSize}) :
    text = value ?? '',
    color = foreground ?? DefaultColors.textColor,
    size = textSize ?? DefaultSizes.subtitleFont,
    weight = FontWeight.bold;

  const TextUtil.label(value, {super.key, foreground, textSize}) :
    text = value ?? '',
    color = foreground ?? DefaultColors.textColor,
    size = textSize ?? DefaultSizes.regularFont,
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