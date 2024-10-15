import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';

class ShowModalBottomSheetComponent {

  static getModal(BuildContext context, Widget title, Widget center, Widget bottom) {
    return showModalBottomSheet<void>(
      backgroundColor: DefaultColors.background,
      shape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: DefaultColors.transparent,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(DefaultSizes.borderRadius)
      ),
      context: context,
      isDismissible: false,
      builder: (context) {
        return BottomSheet(
          backgroundColor: DefaultColors.transparent,
          onClosing: () => {},
          builder: (context) {
            return Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Scaffold(
                  backgroundColor: DefaultColors.transparent,
                  appBar: AppBar(
                    title: title,
                    iconTheme: const IconThemeData(color: DefaultColors.textColor, size:
                    DefaultSizes.smallIcon),
                    backgroundColor: DefaultColors.transparency,
                    toolbarHeight: DefaultSizes.headerHeight,
                    shape: OutlineInputBorder(
                        borderSide: const BorderSide(color: DefaultColors.transparent, width: 0,),
                        borderRadius: BorderRadius.circular(DefaultSizes.borderRadius)
                    ),
                  ),
                  body: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: const BoxDecoration(
                      color: DefaultColors.transparency,
                      borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius)),
                    ),
                    child: center,
                  ),
                  bottomNavigationBar: BottomAppBar(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    color: DefaultColors.transparent,
                    height: DefaultSizes.footerHeight,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      decoration: const BoxDecoration(
                          color: DefaultColors.transparency,
                          borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius))
                      ),
                      child: bottom,
                    ),
                  )
              ),
            );
          },
        );
      },
    );
  }

}