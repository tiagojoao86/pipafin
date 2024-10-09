import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/text_util.dart';

class SnackBarService {
  static SnackBarService? _instance;
  ScaffoldMessengerState? _messenger;

  SnackBarService(BuildContext context) {
    if (_instance == null || _instance!._messenger == null) {
      _instance = SnackBarService._internal(context);
    }
  }

  SnackBarService._internal(BuildContext context) {
    _messenger = ScaffoldMessenger.of(context);
  }

  static void showErrorMessage(String text) {
    _showMessage(text, DefaultColors.redRemove, DefaultColors.white1);
  }

  static void _showMessage(String text, Color backgroundColor, Color foregroundColor) {
    if (_instance == null || _instance!._messenger == null) {
      throw UnimplementedError("SnackBarService is not initialize");
    }
    
    var snackBar = SnackBar(
      content: TextUtil.label(text, foreground: foregroundColor,),
      backgroundColor: backgroundColor,
    );
    _instance!._messenger!.showSnackBar(snackBar);
  }
}