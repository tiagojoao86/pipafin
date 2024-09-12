import 'package:frontend/constants/rest_constants.dart';
import 'package:frontend/model/account_category/account_category_dto.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:frontend/model/account_category/account_category_save.dart';
import 'package:frontend/services/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/model/rest_response.dart';

class AccountCategoryService extends BaseService<AccountCategoryGrid, AccountCategorySave, AccountCategoryDTO> {

  const AccountCategoryService();

  @override
  Future<List<AccountCategoryGrid>> list() async {
    var response = await http.get(getUrl([RestConstants.rAccountCategory]));
    var responseJson = RestResponse<AccountCategoryGrid>
        .fromJson(response, objCreator: () => AccountCategoryGrid());

    return responseJson.body as List<AccountCategoryGrid>;
  }

  @override
  Future<AccountCategoryGrid> save(AccountCategorySave dto) async {
    var response = await http.post(getUrl([RestConstants.rAccountCategory]),
        body: dto.toJson(), headers: getHeaders());
    var responseJson = RestResponse<AccountCategoryGrid>.fromJson(response, objCreator: () => AccountCategoryGrid());

    return responseJson.body as AccountCategoryGrid;
  }

  @override
  Future<String> delete(String uuid) async {
    var response = await http.delete(getUrl([RestConstants.rAccountCategory,'/', uuid]),
        headers: getHeaders());
    var responseJson = RestResponse<String>.fromJson(response);

    return responseJson.body as String;
  }

  @override
  Future<AccountCategoryDTO> findById(String id) async {
    var response = await http.get(
        getUrl([RestConstants.rAccountCategory, RestConstants.rFindById],
            queryParameters: <String, String>{"id":id}),
        headers: getHeaders(),
    );
    var responseJson = RestResponse<AccountCategoryDTO>
        .fromJson(response, objCreator: () => AccountCategoryDTO.empty());

    return responseJson.body as AccountCategoryDTO;
  }

}