import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/components/base/list_component.dart';
import 'package:frontend/components/person/person_detail_component.dart';
import 'package:frontend/enumeration/logic_operators_enum.dart';
import 'package:frontend/enumeration/person_type_enum.dart';
import 'package:frontend/model/person/person_dto.dart';
import 'package:frontend/model/person/person_filter_dto.dart';
import 'package:frontend/model/person/person_grid_dto.dart';
import 'package:frontend/state/person_store_state.dart';

AppLocalizations? location;

class PersonListComponent extends ListComponent<PersonGridDTO, PersonDTO, PersonFilterDTO> {
  const PersonListComponent({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PersonListComponentState();
  }
}

class _PersonListComponentState
    extends ListComponentState<PersonGridDTO, PersonDTO, PersonFilterDTO> {
  _PersonListComponentState() : super(PersonStoreState(), PersonFilterDTO(LogicOperatorsEnum.and));

  @override
  List<Widget> buildInfoList(PersonGridDTO? item) {
    if (item == null) return [];

    var type = item.personType != null
        ? location!.personType(item.personType!.name).toUpperCase()
        : '';
    return [
      item.personType == PersonTypeEnum.legal
          ? TextUtil.label(item.fantasyName)
          : TextUtil.label(item.name),
      TextUtil(type)
    ];
  }

  @override
  List<Widget> buildFilterComponents() {
    return [Row()];
  }

  @override
  Widget buildDetailComponent({String? id}) {
    return PersonDetailComponent(id: id);
  }

  @override
  String getTitleComponent(BuildContext context) {
    location = AppLocalizations.of(context);
    return location!.personTitle;
  }
}
