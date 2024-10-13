import 'package:flutter/material.dart';
import 'package:frontend/l10n/l10n_service.dart';

enum PersonTypeEnum {
  natural,
  legal;

  static PersonTypeEnum fromString(String key) {
    return values.firstWhere((e) => e.name == key.toLowerCase());
  }

  static List<DropdownMenuItem<PersonTypeEnum>> getDropdownList() {
    List<DropdownMenuItem<PersonTypeEnum>> list = [];

    for (PersonTypeEnum item in values) {
      list.add(
        DropdownMenuItem<PersonTypeEnum>(
          value: item,
          child: Text(L10nService.l10n().personType(item.name)),
        ),
      );
    }

    return list;
  }

  @override
  String toString() {
    return L10nService.l10n().personType(name);
  }

}