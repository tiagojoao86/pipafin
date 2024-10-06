import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/text_util.dart';

class DefaultButtons {
  static Widget mainMenuButton(
      VoidCallback cbFunction, String text, Icon icon) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton.icon(
          onPressed: cbFunction,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: DefaultColors.blue1,
            iconColor: DefaultColors.white1,
          ),
          icon: icon,
          label: TextUtil.label(
            text,
            foreground: DefaultColors.white1,
          ),
        )); //#7b9ecf // #5f83b3
  }

  static Widget transparentButton(VoidCallback cbFunction, Icon icon, {iconSize}) {
    return _createInkedButton(cbFunction, DefaultColors.transparent, DefaultColors.blue1, icon, iconSize: iconSize);
  }

  static Widget buttonAdd(VoidCallback cbFunction) {
    return _createInkedButton(cbFunction, DefaultColors.greenAdd,
        DefaultColors.white1, const Icon(CupertinoIcons.add));
  }

  static Widget deleteButton(VoidCallback cbFunction) {
    return _createInkedButton(cbFunction, DefaultColors.redRemove,
        DefaultColors.white1, const Icon(CupertinoIcons.trash_slash));
  }

  static Widget editButton(VoidCallback cbFunction) {
    return _createInkedButton(cbFunction, DefaultColors.yellowEdit,
        DefaultColors.white1, const Icon(Icons.edit));
  }

  static Widget buttonFilter(VoidCallback cbFunction) {
    return _createInkedButton(cbFunction, DefaultColors.blue1,
        DefaultColors.white1, const Icon(CupertinoIcons.search));
  }

  static Widget formSaveButton(VoidCallback cbFunction, String text) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton.icon(
          onPressed: cbFunction,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            backgroundColor: DefaultColors.greenAdd,
            iconColor: DefaultColors.white1,
          ),
          icon: const Icon(Icons.save),
          label: TextUtil(
            text,
            foreground: DefaultColors.white1,
          ),
        ));
  }

  static Widget formCancelButton(VoidCallback cbFunction, String text) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton.icon(
          onPressed: cbFunction,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            backgroundColor: DefaultColors.redRemove,
            iconColor: DefaultColors.white1,
          ),
          icon: const Icon(Icons.cancel),
          label: TextUtil(
            text,
            foreground: DefaultColors.white1,
          ),
        ));
  }

  static Widget formPrimaryButton(
      VoidCallback cbFunction, String text, IconData icon, {textSize = 14.0}) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton.icon(
          onPressed: cbFunction,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
      Color backgroundColor, Color iconColor, Icon icon, {iconSize = 24.0}) {
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
