import 'package:flutter/material.dart';
import 'package:frontend/l10n/l10n_service.dart';

enum AccountCategoryTypeEnum {
  payable,
  receivable;

  static AccountCategoryTypeEnum fromString(String key) {
    return values.firstWhere((e) => e.name == key.toLowerCase());
  }

  static List<DropdownMenuItem<AccountCategoryTypeEnum>> getDropdownList({List<AccountCategoryTypeEnum>? list}) {
    var valuesList = list ?? values;
    List<DropdownMenuItem<AccountCategoryTypeEnum>> componentList = [];

    for (AccountCategoryTypeEnum item in valuesList) {
      componentList.add(
        DropdownMenuItem<AccountCategoryTypeEnum>(
          value: item,
          child: Text(L10nService.l10n().accountCategoryType(item.name).toUpperCase()),
        ),
      );
    }

    return componentList;
  }

}