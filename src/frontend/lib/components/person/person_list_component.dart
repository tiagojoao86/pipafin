import 'package:flutter/material.dart';
import 'package:frontend/components/account_category/account_category_detail_component.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/components/base/list_component.dart';
import 'package:frontend/components/person/person_detail_component.dart';
import 'package:frontend/enumeration/person_type_enum.dart';
import 'package:frontend/model/account_category/account_category_dto.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/model/person/person_dto.dart';
import 'package:frontend/model/person/person_grid_dto.dart';
import 'package:frontend/provider/account_category_provider.dart';
import 'package:frontend/provider/person_provider.dart';

AppLocalizations? location;
class PersonListComponent extends ListComponent<PersonProvider, PersonGridDTO, PersonDTO> {

  const PersonListComponent({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PersonListComponentState();
  }

}

class _PersonListComponentState extends ListComponentState<PersonProvider, PersonGridDTO, PersonDTO> {

  @override
  List<Widget> buildInfoList(PersonGridDTO? item) {
    if (item == null) return [];

    var type = item.personType != null ?
    location!.personType(item.personType!.name)
        .toUpperCase()
        : '';
    return [
      item.personType == PersonTypeEnum.legal ?
      TextUtil.label(item.fantasyName) :
      TextUtil.label(item.name),
      TextUtil(type)
    ];
  }

  @override
  Widget buildDetailComponent(String id) {
    return PersonDetailComponent(id);
  }

  @override
  String getTitleComponent(BuildContext context) {
    location = AppLocalizations.of(context);
    return location!.personTitle;
  }
}