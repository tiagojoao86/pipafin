import 'package:flutter/material.dart';
import 'package:frontend/basics_components/dropdown_component.dart';
import 'package:frontend/basics_components/snack_bar_service.dart';
import 'package:frontend/basics_components/text_form_component.dart';
import 'package:frontend/components/base/controllers.dart';
import 'package:frontend/components/base/detail_component.dart';
import 'package:frontend/enumeration/document_type_enum.dart';
import 'package:frontend/enumeration/person_type_enum.dart';
import 'package:frontend/l10n/l10n_service.dart';
import 'package:frontend/model/person/person_dto.dart';
import 'package:frontend/model/person/person_filter_dto.dart';
import 'package:frontend/model/person/person_grid_dto.dart';
import 'package:frontend/state/person_store_state.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PersonDetailComponent
    extends DetailComponent<PersonGridDTO, PersonDTO, PersonFilterDTO, PersonStoreState> {
  const PersonDetailComponent({super.id, super.key});

  @override
  State<StatefulWidget> createState() {
    return _PersonDetailComponentState();
  }
}

class _PersonDetailComponentState
    extends DetailComponentState<PersonGridDTO, PersonDTO, PersonFilterDTO, PersonStoreState> {
  MaskTextInputFormatter postalCodeFormatter =
      TextFormComponent.postalCodeFormatter;
  MaskTextInputFormatter phoneFormatter = TextFormComponent.phoneFormatter;
  MaskTextInputFormatter cpfFormatter = TextFormComponent.cpfFormatter;

  _PersonDetailComponentState() : super(PersonDTO(), PersonStoreState());

  void _changeTypeRegister(PersonTypeEnum? type) {
    if (type != null) {
      if (PersonTypeEnum.legal == type) {
        dto.documentType = DocumentTypeEnum.cnpj;
      }
      if (PersonTypeEnum.natural == type) {
        dto.documentType = DocumentTypeEnum.cpf;
      }
      store.updateTypePersonState(type);
    }
  }

  @override
  PersonDetailsControllers getControllers() {
    return PersonDetailsControllers.getInstance();
  }

  @override
  List<Widget> buildInnerForm(BuildContext context) {
    return [
      DropdownComponent(
          store.type, emptyValidator, PersonTypeEnum.getDropdownList(),
          (value) {
        _changeTypeRegister(value);
        dto.personType = value;
      }, L10nService.l10n().registerTypeTitle),
      ListenableBuilder(
          listenable: store,
          builder: (context, child) {
            if (store.typePersonState is EmptyPersonState) {
              return const Center();
            }

            return Column(mainAxisSize: MainAxisSize.min, children: [
              ..._getMainDataForm(),
              ..._getAddressForm(),
              ..._getPhonesForm(),
            ]);
          })
    ];
  }

  @override
  String getTitle() {
    return L10nService.l10n().personTitle;
  }

  @override
  void setDataToControllers() {
    if (dto.personType != null && store.type == null) {
      store.updateTypePersonState(dto.personType!);
    }
    if (dto.name != null) {
      getControllers().nameController.text = dto.name!;
    }
    if (dto.fantasyName != null) {
      getControllers().fantasyNameController.text = dto.fantasyName!;
    }
    if (dto.document != null) {
      getControllers().documentController.text = store.maskDocument(dto.document);
    }
    if (dto.addressNumber != null) {
      getControllers().addressNumberController.text = dto.addressNumber!;
    }
    if (dto.addressStreet != null) {
      getControllers().addressStreetController.text = dto.addressStreet!;
    }
    if (dto.addressNeighborhood != null) {
      getControllers().addressNeighborhoodController.text =
          dto.addressNeighborhood!;
    }
    if (dto.addressCity != null) {
      getControllers().addressCityController.text = dto.addressCity!;
    }
    if (dto.addressState != null) {
      getControllers().addressStateController.text = dto.addressState!;
    }
    if (dto.addressPostalCode != null) {
      getControllers().addressPostalCodeController.text =
          postalCodeFormatter.maskText(dto.addressPostalCode!);
    }
    if (dto.phone1 != null) {
      getControllers().phone1Controller.text =
          phoneFormatter.maskText(dto.phone1!);
    }
    if (dto.phone2 != null) {
      getControllers().phone2Controller.text =
          phoneFormatter.maskText(dto.phone2!);
    }
  }

  @override
  Future<void> validateAndSave(Function close) async {
    if (!super.formKey.currentState!.validate()) {
      return;
    }

    var duplicateMessage = await store.verifyDuplicateDocument(
        dto.id,
        store.unmaskDocument(getControllers().documentController.text),
        dto.documentType!);

    if (duplicateMessage != null) {
      SnackBarService.showErrorMessage(duplicateMessage);
      return;
    }

    dto.name = getControllers().nameController.text;
    dto.fantasyName = getControllers().fantasyNameController.text;

    dto.document = store.unmaskDocument(getControllers().documentController.text);

    dto.addressNumber = getControllers().addressNumberController.text;
    dto.addressStreet = getControllers().addressStreetController.text;
    dto.addressNeighborhood =
        getControllers().addressNeighborhoodController.text;
    dto.addressState = getControllers().addressStateController.text;
    dto.addressCity = getControllers().addressCityController.text;
    dto.addressPostalCode = postalCodeFormatter
        .unmaskText(getControllers().addressPostalCodeController.text);
    dto.phone1 =
        phoneFormatter.unmaskText(getControllers().phone1Controller.text);
    dto.phone2 =
        phoneFormatter.unmaskText(getControllers().phone2Controller.text);
    dto.personType = store.type;
    PersonGridDTO? gridDTO = await store.save(dto);
    close(gridDTO);
  }

  List<Widget> _getMainDataForm() {
    return [
      TextFormComponent(L10nService.l10n().name, getControllers().nameController,
          validator: emptyValidator),
      TextFormComponent(
        L10nService.l10n().fantasyName,
        getControllers().fantasyNameController,
        validator: emptyValidator,
        visible: store.typePersonState is LegalPersonState,
      ),
      Row(
        children: [
          DropdownComponent(
              flex: 4,
              dto.documentType,
              emptyValidator,
              DocumentTypeEnum.getDropdownList(list: store.typePersonState.documentTypeList),
              (value) => dto.documentType = value,
              L10nService.l10n().documentTypeTitle),
          TextFormComponent(
            flex: 8,
            L10nService.l10n().document,
            getControllers().documentController,
            validator: store.typePersonState.documentValidator,
            formatter: store.typePersonState.documentFormatter,
          ),
        ],
      ),
    ];
  }

  List<Widget> _getAddressForm() {
    return [
      TextFormComponent(L10nService.l10n().addressPostalCode,
          getControllers().addressPostalCodeController,
          validator: emptyValidator, formatter: postalCodeFormatter),
      Row(children: [
        TextFormComponent(
            flex: 8,
            L10nService.l10n().addressStreet,
            getControllers().addressStreetController,
            validator: emptyValidator),
        TextFormComponent(
          flex: 2,
          L10nService.l10n().addressNumber,
          getControllers().addressNumberController,
        ),
      ]),
      Row(children: [
        TextFormComponent(L10nService.l10n().addressNeighborhood,
            getControllers().addressNeighborhoodController,
            validator: emptyValidator),
        TextFormComponent(
            L10nService.l10n().addressCity, getControllers().addressCityController,
            validator: emptyValidator),
        TextFormComponent(
            L10nService.l10n().addressState, getControllers().addressStateController,
            validator: emptyValidator),
      ]),
    ];
  }

  List<Widget> _getPhonesForm() {
    return [
      Row(children: [
        TextFormComponent(
          flex: 5,
          L10nService.l10n().phone1,
          getControllers().phone1Controller,
          validator: emptyValidator,
          formatter: phoneFormatter,
        ),
        TextFormComponent(
          flex: 5,
          L10nService.l10n().phone2,
          getControllers().phone2Controller,
          formatter: phoneFormatter,
        ),
      ]),
    ];
  }
}

class PersonDetailsControllers extends Controllers {
  static PersonDetailsControllers? _instance;

  static getInstance() {
    _instance ??= PersonDetailsControllers();
    return _instance;
  }

  @override
  void clear() {
    nameController.clear();
    fantasyNameController.clear();
    documentController.clear();
    addressNumberController.clear();
    addressStreetController.clear();
    addressNeighborhoodController.clear();
    addressCityController.clear();
    addressStateController.clear();
    addressPostalCodeController.clear();
    phone1Controller.clear();
    phone2Controller.clear();
  }

  final nameController = TextEditingController();
  final fantasyNameController = TextEditingController();
  final documentController = TextEditingController();
  final addressNumberController = TextEditingController();
  final addressStreetController = TextEditingController();
  final addressNeighborhoodController = TextEditingController();
  final addressCityController = TextEditingController();
  final addressStateController = TextEditingController();
  final addressPostalCodeController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();
}
