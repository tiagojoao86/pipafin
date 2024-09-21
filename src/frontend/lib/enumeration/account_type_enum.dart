import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/basics_components/text_util.dart';

enum AccountTypeEnum {
  payable,
  receivable;

  static AccountTypeEnum fromString(String key) {
    return values.firstWhere((e) => e.name == key.toLowerCase());
  }

  static List<DropdownMenuItem<AccountTypeEnum>> getDropdownList(BuildContext context) {
    AppLocalizations? location = AppLocalizations.of(context);
    List<DropdownMenuItem<AccountTypeEnum>> list = [];

    for (AccountTypeEnum item in values) {
      list.add(
        DropdownMenuItem<AccountTypeEnum>(
          value: item,
          child: TextUtil(location!.accountCategoryType(item.name).toUpperCase(), textSize: 16,),
        ),
      );
    }

    return list;
  }

}