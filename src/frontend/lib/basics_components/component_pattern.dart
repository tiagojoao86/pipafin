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

  static var buttonTextIconOverlayColor = WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return DefaultColors.transparency;
      }
      return DefaultColors.secondaryColor;
    }
  );

  static var buttonTextIconForegroundColor = WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return DefaultColors.invertedTextColor;
      } else if (states.contains(WidgetState.hovered)) {
        return DefaultColors.invertedTextColor;
      }
      return DefaultColors.textColor;
    }
  );

  static var buttonTextIconTextStyle = WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return ComponentPattern.invertedTextStyle;
      } else if (states.contains(WidgetState.hovered)) {
        return ComponentPattern.invertedTextStyle;
      }
      return ComponentPattern.textStyle;
    },
  );

  static var buttonTextIconBackground = WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return DefaultColors.background;
      }
      return DefaultColors.itemTransparent;
    }
  );

  static var buttonTextIconBorder = CustomOutlinedBorder();

  static var buttonTextIconStyle = ButtonStyle(
    overlayColor: ComponentPattern.buttonTextIconOverlayColor,
    foregroundColor: ComponentPattern.buttonTextIconForegroundColor,
    shape: ComponentPattern.buttonTextIconBorder,
    backgroundColor: ComponentPattern.buttonTextIconBackground,
    textStyle: ComponentPattern.buttonTextIconTextStyle,
  );
}

class CustomOutlinedBorder extends OutlinedBorder implements WidgetStateOutlinedBorder {

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getOuterPath
    throw UnimplementedError();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
  }

  @override
  OutlinedBorder? resolve(Set<WidgetState> states) {
    return const RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius))
    );
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement resolve
    throw UnimplementedError();
  }

}