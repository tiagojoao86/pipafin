import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';
import 'package:frontend/basics_components/text_util.dart';

class DefaultButtons {
  static Widget mainMenuButton(
      VoidCallback cbFunction, String text, Icon icon) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextButton.icon(
          onPressed: cbFunction,
          style: ElevatedButton.styleFrom(
            shape:  const RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius))),
            backgroundColor: DefaultColors.itemTransparent,
            iconColor: DefaultColors.textColor,
          ),
          icon: icon,
          label: TextUtil.label(
            text,
            foreground: DefaultColors.textColor,
          ),
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

  static Widget formSaveButton(VoidCallback cbFunction, String text) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
        child:  TextButton.icon(
          onPressed: cbFunction,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius))),
            backgroundColor: DefaultColors.itemTransparent,
            iconColor: DefaultColors.textColor,
          ),
          icon: const Icon(Icons.save),
          label: TextUtil(
            text,
            foreground: DefaultColors.textColor,
          ),
        ));
  }

  static Widget formCancelButton(VoidCallback cbFunction, String text) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: TextButton.icon(
          onPressed: cbFunction,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius))),
            backgroundColor: DefaultColors.itemTransparent,
            iconColor: DefaultColors.textColor,
          ),
          icon: const Icon(Icons.cancel),
          label: TextUtil(
            text,
            foreground: DefaultColors.textColor,
          ),
        ));
  }

  static Widget formPrimaryButton(
      VoidCallback cbFunction, String text, IconData icon, {textSize = DefaultSizes.regularFont}) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton.icon(
          onPressed: cbFunction,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius))),
            backgroundColor: DefaultColors.blue1,
            iconColor: DefaultColors.white1,
          ),
          icon: Icon(icon),
          label: TextUtil(
            text,
            foreground: DefaultColors.white1,
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
            child: IconButton(
              icon: icon,
              color: iconColor,
              onPressed: cbFunction,
              iconSize: iconSize,
            ),
          ),
        ));
  }
}
