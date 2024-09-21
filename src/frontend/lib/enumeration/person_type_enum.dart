import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/basics_components/text_util.dart';

enum PersonTypeEnum {
  natural,
  legal;

  static PersonTypeEnum fromString(String key) {
    return values.firstWhere((e) => e.name == key.toLowerCase());
  }

  static List<DropdownMenuItem<PersonTypeEnum>> getDropdownList(BuildContext context) {
    AppLocalizations? location = AppLocalizations.of(context);
    List<DropdownMenuItem<PersonTypeEnum>> list = [];

    for (PersonTypeEnum item in values) {
      list.add(
        DropdownMenuItem<PersonTypeEnum>(
          value: item,
          child: TextUtil(location!.personType(item.name), textSize: 16,),
        ),
      );
    }

    return list;
  }

}