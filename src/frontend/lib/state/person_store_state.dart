import 'package:frontend/basics_components/text_form_component.dart';
import 'package:frontend/enumeration/document_type_enum.dart';
import 'package:frontend/enumeration/person_type_enum.dart';
import 'package:frontend/model/person/person_dto.dart';
import 'package:frontend/model/person/person_filter_dto.dart';
import 'package:frontend/model/person/person_grid_dto.dart';
import 'package:frontend/services/person_service.dart';
import 'package:frontend/state/base_store_state.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PersonStoreState extends BaseStoreState<PersonGridDTO, PersonDTO, PersonFilterDTO> {
  MaskTextInputFormatter cpfFormatter = TextFormComponent.cpfFormatter;
  PersonTypeEnum? type;
  TypePersonState typePersonState = EmptyPersonState();

  PersonStoreState() : super(const PersonService());

  updateTypePersonState(PersonTypeEnum newType) {
    type = newType;
    if (PersonTypeEnum.legal == newType) {
      typePersonState =
          LegalPersonState(MaskTextInputFormatter(), [DocumentTypeEnum.cnpj]);
      notifyListeners();
      return;
    }

    typePersonState = NaturalPersonState(cpfFormatter, [DocumentTypeEnum.cpf]);
    notifyListeners();
  }
}

sealed class TypePersonState {
  MaskTextInputFormatter documentFormatter;
  List<DocumentTypeEnum> documentTypeList;

  TypePersonState(this.documentFormatter, this.documentTypeList);
}

class LegalPersonState extends TypePersonState {
  LegalPersonState(super.documentFormatter, super.documentTypeList);
}

class NaturalPersonState extends TypePersonState {
  NaturalPersonState(super.documentFormatter, super.documentTypeList);
}

class EmptyPersonState extends TypePersonState {
  EmptyPersonState() : super(MaskTextInputFormatter(), []);
}
