import 'package:flutter/material.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/components/base/list_component.dart';
import 'package:frontend/components/person/person_detail_component.dart';
import 'package:frontend/enumeration/logic_operators_enum.dart';
import 'package:frontend/enumeration/person_type_enum.dart';
import 'package:frontend/l10n/l10n_service.dart';
import 'package:frontend/model/data/pageable_data_request.dart';
import 'package:frontend/model/person/person_dto.dart';
import 'package:frontend/model/person/person_filter_dto.dart';
import 'package:frontend/model/person/person_grid_dto.dart';
import 'package:frontend/state/person_store_state.dart';

class PersonListComponent extends ListComponent<PersonGridDTO, PersonDTO, PersonFilterDTO> {
  const PersonListComponent({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PersonListComponentState();
  }
}

class _PersonListComponentState
    extends ListComponentState<PersonGridDTO, PersonDTO, PersonFilterDTO> {
  _PersonListComponentState() : super(PersonStoreState(), PageableDataRequest.basic(PersonFilterDTO(LogicOperatorsEnum.and)));

  @override
  List<Widget> buildInfoList(PersonGridDTO? item) {
    if (item == null) return [];

    var type = item.personType != null
        ? L10nService.l10n().personType(item.personType!.name).toUpperCase()
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
    return [const Row()];
  }

  @override
  Widget buildDetailComponent({String? id}) {
    return PersonDetailComponent(id: id);
  }

  @override
  String getTitleComponent(BuildContext context) {
    return L10nService.l10n().personTitle;
  }
}
