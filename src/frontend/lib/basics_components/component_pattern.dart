import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';

class ComponentPattern {
  static const border = OutlineInputBorder(
      borderSide: BorderSide(
          color: DefaultColors.textColor,
          width: 1.0
      )
  );

  static const focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(
          color: DefaultColors.secondaryColor,
          width: 2.0
      )
  );

  static const errorBorder = OutlineInputBorder(
      borderSide: BorderSide(
          color: DefaultColors.dangerColor,
          width: 2.0
      )
  );

  static const textStyle = TextStyle(
    color: DefaultColors.textColor,
    fontSize: DefaultSizes.regularFont
  );

  static const invertedTextStyle = TextStyle(
    color: DefaultColors.invertedTextColor,
    fontSize: DefaultSizes.regularFont
  );

  static const focusedTextStyle = TextStyle(
    color: DefaultColors.secondaryColor,
    fontSize: DefaultSizes.regularFont
  );

  static const errorTextStyle = TextStyle(
    color: DefaultColors.dangerColor,
    fontSize: DefaultSizes.regularFont
  );
}