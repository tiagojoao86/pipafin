import 'package:flutter/material.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/l10n/l10n_service.dart';

enum DocumentTypeEnum {
  cpf,
  cnpj;

  static DocumentTypeEnum fromString(String key) {
    return values.firstWhere((e) => e.name == key.toLowerCase());
  }

  static List<DropdownMenuItem<DocumentTypeEnum>> getDropdownList() {
    List<DropdownMenuItem<DocumentTypeEnum>> list = [];

    for (DocumentTypeEnum item in values) {
      list.add(
        DropdownMenuItem<DocumentTypeEnum>(
          value: item,
          child: TextUtil(L10nService.l10n().documentType(item.name).toUpperCase(), textSize: 16,),
        ),
      );
    }

    return list;
  }

}