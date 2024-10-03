import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/text_util.dart';

class AppBarRegisterComponent extends AppBar {
  AppBarRegisterComponent(
      VoidCallback cbAdd, VoidCallback cbFilter, String title,
      {super.key})
      : super(
          title: TextUtil.subTitle(title, foreground: DefaultColors.black1),
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: DefaultButtons.buttonAdd(cbAdd)),
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 17.0, 0.0),
                child: DefaultButtons.buttonFilter(cbFilter))
          ],
        );
}
