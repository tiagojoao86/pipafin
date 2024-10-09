import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10nService {
  static L10nService? _instance;
  AppLocalizations? appLocalizations;

  L10nService(BuildContext context) {
    if (_instance == null || _instance!.appLocalizations == null) {
      _instance = L10nService._internal(context);
    }
  }

  L10nService._internal(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
  }

  static AppLocalizations l10n() {
    if (_instance == null || _instance!.appLocalizations == null) {
      throw UnimplementedError("L10nService is not initialize");
    }
    return _instance!.appLocalizations!;
  }
}