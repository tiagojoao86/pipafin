import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/basics_components/component_pattern.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';

class DefaultButtons {
  static Widget mainMenuButton(
      VoidCallback cbFunction, String text, Icon icon) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextButton.icon(
          style: ComponentPattern.buttonTextIconStyle,
          onPressed: cbFunction,
          icon: icon,
          label: Text(text)
        )); //#7b9ecf // #5f83b3
  }

  static Widget transparentButton(VoidCallback cbFunction, Icon icon,
      {iconSize = DefaultSizes.regularIcon, foregroundColor = DefaultColors.textColor}) {
    return _createIconButton(cbFunction, DefaultColors.transparent,
        foregroundColor, icon, iconSize: iconSize);
  }

  static Widget buttonAdd(VoidCallback cbFunction, {iconSize = DefaultSizes.regularIcon,
    iconColor = DefaultColors.textColor, backgroundColor = DefaultColors.transparent}) {
    return _createInkedButton(cbFunction, backgroundColor,
        iconColor, const Icon(Icons.add), iconSize: iconSize);
  }

  static Widget deleteButton(VoidCallback cbFunction, {iconSize = DefaultSizes.regularIcon,
  iconColor = DefaultColors.textColor, backgroundColor = DefaultColors.transparent}) {
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

  static Widget formSaveButton(VoidCallback cbFunction, String text) {
    return formButton(cbFunction, text, Icons.save);
  }

  static Widget formCancelButton(VoidCallback cbFunction, String text) {
    return formButton(cbFunction, text, Icons.cancel);
  }

  static Widget formButton(VoidCallback cbFunction, String text, IconData icon) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextButton.icon(
          onPressed: cbFunction,
          style: ComponentPattern.buttonTextIconStyle,
          icon: Icon(icon),
          label: Text(text),
        ));
  }

  static Widget _createIconButton(VoidCallback cbFunction,
      Color backgroundColor, Color iconColor, Icon icon, {iconSize = DefaultSizes.regularIcon}) {
    return IconButton(
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
    );
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
            child: _createIconButton(cbFunction, backgroundColor, iconColor, icon, iconSize: iconSize),

          ),
        )
    );
  }
}
