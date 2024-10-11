import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/basics_components/component_pattern.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';
import 'package:frontend/basics_components/text_util.dart';

class DefaultButtons {
  static Widget mainMenuButton(
      VoidCallback cbFunction, String text, Icon icon) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextButton.icon(
          style: ButtonStyle(
            overlayColor:
            WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return DefaultColors.transparency;
                }
                return DefaultColors.secondaryColor;
              }
            ),
            foregroundColor:
            WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return DefaultColors.invertedTextColor;
                } else if (states.contains(WidgetState.hovered)) {
                  return DefaultColors.invertedTextColor;
                }
                return DefaultColors.textColor;
              }
            ),
            shape: CustomOutlinedBorder(),
            backgroundColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return DefaultColors.background;
                }
                return DefaultColors.itemTransparent;
              }
            ),
            textStyle:
            WidgetStateTextStyle.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return ComponentPattern.invertedTextStyle;
                } else if (states.contains(WidgetState.hovered)) {
                  return ComponentPattern.invertedTextStyle;
                }
                return ComponentPattern.textStyle;
              },
            )
          ),
          onPressed: cbFunction,
          icon: icon,
          label: Text(text)
        )); //#7b9ecf // #5f83b3
  }

  static Widget transparentButton(VoidCallback cbFunction, Icon icon,
      {iconSize = DefaultSizes.regularIcon, foregroundColor = DefaultColors.black2}) {
    return _createInkedButton(cbFunction, DefaultColors.transparent,
        foregroundColor, icon, iconSize: iconSize);
  }

  static Widget buttonAdd(VoidCallback cbFunction, {iconSize = DefaultSizes.regularIcon,
    iconColor = DefaultColors.greenAdd, backgroundColor = DefaultColors.transparent}) {
    return _createInkedButton(cbFunction, backgroundColor,
        iconColor, const Icon(Icons.add), iconSize: iconSize);
  }

  static Widget deleteButton(VoidCallback cbFunction, {iconSize = DefaultSizes.regularIcon,
  iconColor = DefaultColors.redRemove, backgroundColor = DefaultColors.transparent}) {
    return _createInkedButton(cbFunction, backgroundColor,
        iconColor, const Icon(Icons.delete_forever_rounded), iconSize: iconSize);
  }

  static Widget editButton(VoidCallback cbFunction, {iconSize = DefaultSizes.regularIcon,
    iconColor = DefaultColors.yellowEdit, backgroundColor = DefaultColors.transparent}) {
    return _createInkedButton(cbFunction, backgroundColor,
        iconColor, const Icon(Icons.edit), iconSize: iconSize);
  }

  static Widget buttonFilter(VoidCallback cbFunction, {iconSize = DefaultSizes.regularIcon,
    iconColor = DefaultColors.black2, backgroundColor = DefaultColors.transparent}) {
    return _createInkedButton(cbFunction, backgroundColor,
        iconColor, const Icon(CupertinoIcons.search), iconSize: iconSize);
  }

  static Widget formSaveButton(VoidCallback cbFunction, String text, {backgroundColor = DefaultColors.itemTransparent,
    iconColor = DefaultColors.textColor, textColor = DefaultColors.textColor}) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
        child:  TextButton.icon(
          onPressed: cbFunction,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius))),
            backgroundColor: backgroundColor,
            iconColor: iconColor,
          ),
          icon: const Icon(Icons.save),
          label: TextUtil(
            text,
            foreground: textColor,
          ),
        ));
  }

  static Widget formCancelButton(VoidCallback cbFunction, String text, {backgroundColor = DefaultColors.itemTransparent,
    iconColor = DefaultColors.textColor, textColor = DefaultColors.textColor}) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: TextButton.icon(
          onPressed: cbFunction,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius))
            ),
            backgroundColor: backgroundColor,
            iconColor: iconColor,
          ),
          icon: const Icon(Icons.cancel),
          label: TextUtil(
            text,
            foreground: textColor,
          ),
        ));
  }

  static Widget formButton(
      VoidCallback cbFunction, String text, IconData icon,
      {textSize = DefaultSizes.regularFont, backgroundColor = DefaultColors.itemTransparent,
        iconColor = DefaultColors.textColor, textColor = DefaultColors.textColor}) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextButton.icon(
          onPressed: cbFunction,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius))),
            backgroundColor: backgroundColor,
            iconColor: iconColor,
          ),
          icon: Icon(icon),
          label: TextUtil(
            text,
            foreground: textColor,
            textSize: textSize,
          ),
        ));
  }

  static Widget _createInkedButton(VoidCallback cbFunction,
      Color backgroundColor, Color iconColor, Icon icon, {iconSize = DefaultSizes.regularIcon}) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
          child: Ink(
            decoration: ShapeDecoration(
              color: backgroundColor,
              shape: const CircleBorder(),
            ),
            child:
            IconButton(
              style: ButtonStyle(
                overlayColor:
                  WidgetStateColor.resolveWith((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return DefaultColors.transparency;
                    }
                    return DefaultColors.secondaryColor;
                  }
                ),
                foregroundColor:
                  WidgetStateColor.resolveWith((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return DefaultColors.invertedTextColor;
                    } else if (states.contains(WidgetState.hovered)) {
                      return DefaultColors.invertedTextColor;
                    }
                    return iconColor;
                  }
                ),
              ),
              icon: icon,
              onPressed: cbFunction,
              iconSize: iconSize,
            ),
          ),
        )
    );
  }
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
