import 'package:frontend/basics_components/text_form_component.dart';
import 'package:frontend/enumeration/document_type_enum.dart';
import 'package:frontend/enumeration/person_type_enum.dart';
import 'package:frontend/l10n/l10n_service.dart';
import 'package:frontend/model/person/person_dto.dart';
import 'package:frontend/model/person/person_filter_dto.dart';
import 'package:frontend/model/person/person_grid_dto.dart';
import 'package:frontend/services/person_service.dart';
import 'package:frontend/state/base_store_state.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PersonStoreState extends BaseStoreState<PersonGridDTO, PersonDTO, PersonFilterDTO> {
  MaskTextInputFormatter cpfFormatter = TextFormComponent.cpfFormatter;
  MaskTextInputFormatter cnpjFormatter = TextFormComponent.cnpjFormatter;
  String? Function(dynamic)? cpfValidator = TextFormComponent.cpfValidator;
  String? Function(dynamic)? cnpjValidator = TextFormComponent.cnpjValidator;
  PersonTypeEnum? type;
  TypePersonState typePersonState = EmptyPersonState();

  PersonStoreState() : super(const PersonService());

  updateTypePersonState(PersonTypeEnum newType) {
    type = newType;
    if (PersonTypeEnum.legal == newType) {
      typePersonState =
          LegalPersonState(cnpjFormatter, [DocumentTypeEnum.cnpj], cnpjValidator);
      notifyListeners();
      return;
    }

    typePersonState = NaturalPersonState(cpfFormatter, [DocumentTypeEnum.cpf], cpfValidator);
    notifyListeners();
  }

  Future<String?> verifyDuplicateDocument(text, DocumentTypeEnum documentType) async {
    var response = await (service as PersonService).verifyDuplicateDocument(text, documentType);

    if (response == true) {
      return L10nService.l10n().duplicateInfo(documentType.name.toUpperCase());
    }

    return null;
  }

  String unmaskDocument(text) {
    return typePersonState.documentFormatter.unmaskText(text);
  }

  String maskDocument(text) {
    return typePersonState.documentFormatter.maskText(text);
  }
}



sealed class TypePersonState {
  String? Function(dynamic)? documentValidator;
  MaskTextInputFormatter documentFormatter;
  List<DocumentTypeEnum> documentTypeList;

  TypePersonState(this.documentFormatter, this.documentTypeList, this.documentValidator);
}

class LegalPersonState extends TypePersonState {
  LegalPersonState(super.documentFormatter, super.documentTypeList, super.documentValidator);
}

class NaturalPersonState extends TypePersonState {
  NaturalPersonState(super.documentFormatter, super.documentTypeList, super.documentValidator);
}

class EmptyPersonState extends TypePersonState {
  EmptyPersonState() : super(MaskTextInputFormatter(), [], (value) => null);
}
