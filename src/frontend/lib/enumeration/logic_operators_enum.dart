import 'package:flutter/material.dart';
import 'package:frontend/l10n/l10n_service.dart';

enum LogicOperatorsEnum {
  and,
  or;

  static LogicOperatorsEnum fromString(String key) {
    return values.firstWhere((e) => e.name == key.toLowerCase());
  }

  static List<DropdownMenuItem<LogicOperatorsEnum>> getDropdownList() {
    List<DropdownMenuItem<LogicOperatorsEnum>> list = [];

    for (LogicOperatorsEnum item in values) {
      list.add(
        DropdownMenuItem<LogicOperatorsEnum>(
          value: item,
          child: Text(L10nService.l10n().logicOperation(item.name)),
        ),
      );
    }

    return list;
  }

  @override
  String toString() {
    return L10nService.l10n().logicOperation(name);
  }
}