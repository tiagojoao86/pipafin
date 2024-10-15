import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';
import 'package:frontend/basics_components/text_util.dart';

class AppBarRegisterComponent extends AppBar {
  final BuildContext context;
  AppBarRegisterComponent(
      VoidCallback cbAdd, VoidCallback cbFilter, VoidCallback cbSort, String title, this.context,
      {super.key})
      : super(
          leading: DefaultButtons.transparentButton(
                  () => Navigator.pop(context), const Icon(Icons.arrow_back)
          ),
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
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: DefaultButtons.buttonFilter(cbFilter, iconColor: DefaultColors.textColor)),
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: DefaultButtons.transparentButton(cbSort, const Icon(Icons.sort)))
          ],
        );
}
