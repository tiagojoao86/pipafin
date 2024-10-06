import 'package:flutter/material.dart';
import 'package:frontend/basics_components/text_util.dart';
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
          child: TextUtil(L10nService.l10n().personType(item.name), textSize: 16,),
        ),
      );
    }

    return list;
  }

}