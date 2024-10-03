import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/basics_components/text_util.dart';

enum AccountCategoryTypeEnum {
  payable,
  receivable;

  static AccountCategoryTypeEnum fromString(String key) {
    return values.firstWhere((e) => e.name == key.toLowerCase());
  }

  static List<DropdownMenuItem<AccountCategoryTypeEnum>> getDropdownList(BuildContext context) {
    AppLocalizations? location = AppLocalizations.of(context);
    List<DropdownMenuItem<AccountCategoryTypeEnum>> list = [];

    for (AccountCategoryTypeEnum item in values) {
      list.add(
        DropdownMenuItem<AccountCategoryTypeEnum>(
          value: item,
          child: TextUtil(location!.accountCategoryType(item.name).toUpperCase(), textSize: 16,),
        ),
      );
    }

    return list;
  }

}