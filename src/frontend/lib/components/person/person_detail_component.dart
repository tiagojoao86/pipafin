import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/basics_components/dropdown_component.dart';
import 'package:frontend/basics_components/text_form_component.dart';
import 'package:frontend/components/base/detail_component.dart';
import 'package:frontend/enumeration/document_type_enum.dart';
import 'package:frontend/enumeration/person_type_enum.dart';
import 'package:frontend/model/person/person_dto.dart';
import 'package:frontend/model/person/person_grid_dto.dart';
import 'package:frontend/provider/person_provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PersonDetailComponent
    extends DetailComponent<PersonProvider, PersonGridDTO, PersonDTO> {
  const PersonDetailComponent(super.id, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PersonDetailComponentState();
  }
}

class _PersonDetailComponentState
    extends DetailComponentState<PersonProvider, PersonGridDTO, PersonDTO> {
  MaskTextInputFormatter postalCodeFormatter = TextFormComponent.postalCodeFormatter;
  MaskTextInputFormatter phoneFormatter = TextFormComponent.phoneFormatter;
  MaskTextInputFormatter cpfFormatter = TextFormComponent.cpfFormatter;
  PersonTypeEnum? registerType;

  void _changeTypeRegister(PersonTypeEnum? type) {
    setState(() {
      registerType = type;
    });
  }

  @override
  PersonDetailsControllers getControllers() {
    return PersonDetailsControllers.getInstance();
  }

  @override
  List<Widget> buildInnerForm(PersonDTO dto, BuildContext context) {
    return [
      DropdownComponent(
          registerType, emptyValidator, PersonTypeEnum.getDropdownList(context),
          (value) {
        _changeTypeRegister(value);
        dto.personType = value;
      }, location!.registerTypeTitle),
      Visibility(
        visible: registerType != null,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ..._getMainDataForm(dto),
          ..._getAddressForm(dto),
          ..._getPhonesForm(dto),
        ]),
      )
    ];
  }

  @override
  getDtoBuildFunction() {
    return PersonDTO();
  }

  @override
  String getTitle(AppLocalizations? location) {
    return location!.personTitle;
  }

  @override
  void setDataToControllers(PersonDTO dto) {
    if (dto.personType != null && registerType == null) {
      registerType = dto.personType;
    }
    if (dto.name != null) {
      getControllers().nameController.text = dto.name!;
    }
    if (dto.fantasyName != null) {
      getControllers().fantasyNameController.text = dto.fantasyName!;
    }
    if (dto.document != null) {
      if (dto.documentType == DocumentTypeEnum.cpf) {
        getControllers().documentController.text = cpfFormatter.maskText(dto.document!);
      } else {
        getControllers().documentController.text = dto.document!;
      }
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
      getControllers().phone1Controller.text = phoneFormatter.maskText(dto.phone1!);
    }
    if (dto.phone2 != null) {
      getControllers().phone2Controller.text = phoneFormatter.maskText(dto.phone2!);
    }
  }

  @override
  Future<void> validateAndSave(PersonDTO dto, PersonProvider provider, formKey,
      VoidCallback close) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    dto.name = getControllers().nameController.text;
    dto.fantasyName = getControllers().fantasyNameController.text;

    dto.document = dto.documentType == DocumentTypeEnum.cpf ?
      cpfFormatter.unmaskText(getControllers().documentController.text) :
      getControllers().documentController.text;

    dto.addressNumber = getControllers().addressNumberController.text;
    dto.addressStreet = getControllers().addressStreetController.text;
    dto.addressNeighborhood =
        getControllers().addressNeighborhoodController.text;
    dto.addressState = getControllers().addressStateController.text;
    dto.addressCity = getControllers().addressCityController.text;
    dto.addressPostalCode =
        postalCodeFormatter.unmaskText(getControllers().addressPostalCodeController.text);
    dto.phone1 = phoneFormatter.unmaskText(getControllers().phone1Controller.text);
    dto.phone2 = phoneFormatter.unmaskText(getControllers().phone2Controller.text);
    dto.personType = registerType;
    provider.save(dto);
    close();
  }

  List<Widget> _getMainDataForm(PersonDTO dto) {
    return [
      TextFormComponent(
          location!.name, getControllers().nameController,
          validator: emptyValidator),
      TextFormComponent(
        location!.fantasyName,
        getControllers().fantasyNameController,
        validator: emptyValidator,
        visible: registerType == PersonTypeEnum.legal,
      ),
      Row(
        children: [
          DropdownComponent(
            flex: 2,
            dto.documentType,
            emptyValidator,
            DocumentTypeEnum.getDropdownList(context),
            (value) => dto.documentType = value,
            location!.documentTypeTitle),
          TextFormComponent(
            flex: 8,
            location!.document,
            getControllers().documentController,
            validator:
              dto.documentType == DocumentTypeEnum.cpf ?
              TextFormComponent.cpfValidator : emptyValidator,
            formatter: dto.documentType == DocumentTypeEnum.cpf ? cpfFormatter : null,
          ),
        ],
      ),
    ];
  }

  List<Widget> _getAddressForm(PersonDTO dto) {
    return [
      TextFormComponent(location!.addressPostalCode,
        getControllers().addressPostalCodeController,
        validator: emptyValidator,
        formatter: postalCodeFormatter),
      Row(children: [
        TextFormComponent(
            flex: 8,
            location!.addressStreet,
            getControllers().addressStreetController,
            validator: emptyValidator),
        TextFormComponent(
            flex: 2,
            location!.addressNumber,
            getControllers().addressNumberController, ),
      ]),
      Row(children: [
        TextFormComponent(location!.addressNeighborhood,
            getControllers().addressNeighborhoodController,
            validator: emptyValidator),
        TextFormComponent(location!.addressCity,
            getControllers().addressCityController,
            validator: emptyValidator),
        TextFormComponent(location!.addressState,
            getControllers().addressStateController,
            validator: emptyValidator),
      ]),
    ];
  }

  List<Widget> _getPhonesForm(PersonDTO dto) {
    return [
      Row(children: [
        TextFormComponent(
          flex: 5,
          location!.phone1,
          getControllers().phone1Controller,
          validator: emptyValidator,
          formatter: phoneFormatter,
        ),
        TextFormComponent(
          flex: 5,
          location!.phone2,
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
