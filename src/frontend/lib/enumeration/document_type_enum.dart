import 'package:flutter/material.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/l10n/l10n_service.dart';

enum DocumentTypeEnum {
  cpf,
  cnpj;

  static DocumentTypeEnum fromString(String key) {
    return values.firstWhere((e) => e.name == key.toLowerCase());
  }

  static List<DropdownMenuItem<DocumentTypeEnum>> getDropdownList({List<DocumentTypeEnum>? list}) {
    var valuesList = list ?? values;
    List<DropdownMenuItem<DocumentTypeEnum>> componentList = [];

    for (DocumentTypeEnum item in valuesList) {
      componentList.add(
        DropdownMenuItem<DocumentTypeEnum>(
          value: item,
          child: Text(L10nService.l10n().documentType(item.name).toUpperCase()),
        ),
      );
    }

    return componentList;
  }

}