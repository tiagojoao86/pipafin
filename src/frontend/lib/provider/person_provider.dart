import 'package:frontend/model/account_category/account_category_dto.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:frontend/model/person/person_dto.dart';
import 'package:frontend/model/person/person_grid_dto.dart';
import 'package:frontend/provider/base_provider.dart';
import 'package:frontend/services/account_category_service.dart';
import 'package:frontend/services/person_service.dart';

class PersonProvider extends BaseProvider<PersonGridDTO, PersonDTO> {

  @override
  PersonService getService() {
    return const PersonService();
  }

}