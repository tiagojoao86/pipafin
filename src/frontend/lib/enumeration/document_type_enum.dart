import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/basics_components/text_util.dart';

enum DocumentTypeEnum {
  cpf,
  cnpj;

  static DocumentTypeEnum fromString(String key) {
    return values.firstWhere((e) => e.name == key.toLowerCase());
  }

  static List<DropdownMenuItem<DocumentTypeEnum>> getDropdownList(BuildContext context) {
    AppLocalizations? location = AppLocalizations.of(context);
    List<DropdownMenuItem<DocumentTypeEnum>> list = [];

    for (DocumentTypeEnum item in values) {
      list.add(
        DropdownMenuItem<DocumentTypeEnum>(
          value: item,
          child: TextUtil(location!.documentType(item.name).toUpperCase(), textSize: 16,),
        ),
      );
    }

    return list;
  }

}