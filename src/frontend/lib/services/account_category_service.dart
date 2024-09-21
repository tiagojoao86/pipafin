import 'dart:ui';
import 'package:frontend/constants/rest_constants.dart';
import 'package:frontend/model/account_category/account_category_dto.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:frontend/services/base_service.dart';

class AccountCategoryService extends BaseService<AccountCategoryGrid, AccountCategoryDTO> {

  const AccountCategoryService();

  @override
  VoidCallback getDtoObjectConstructor() {
    return () => AccountCategoryDTO();
  }

  @override
  VoidCallback getGridObjectConstructor() {
    return () => AccountCategoryGrid();
  }

  @override
  Uri getUrl(List<String> complements, {queryParameters}) {
    complements.insert(0, RestConstants.rAccountCategory);
    return getBaseUrl(complements, queryParameters: queryParameters);
  }
}