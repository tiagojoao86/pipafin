import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';
import 'package:frontend/basics_components/text_util.dart';

class AppBarRegisterComponent extends AppBar {
  AppBarRegisterComponent(
      VoidCallback cbAdd, VoidCallback cbFilter, String title,
      {super.key})
      : super(
          backgroundColor: DefaultColors.transparency,
          toolbarHeight: DefaultSizes.headerHeight,
          shape: OutlineInputBorder(
              borderSide: const BorderSide(color: DefaultColors.transparent, width: 0,),
              borderRadius: BorderRadius.circular(DefaultSizes.borderRadius)
          ),
          iconTheme: const IconThemeData(color: DefaultColors.textColor, size:
          DefaultSizes.smallIcon),
          title: TextUtil.subTitle(title, foreground: DefaultColors.textColor),
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: DefaultButtons.buttonAdd(cbAdd, iconColor: DefaultColors.textColor)),
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 17.0, 0.0),
                child: DefaultButtons.buttonFilter(cbFilter, iconColor: DefaultColors.textColor))
          ],
        );
}
