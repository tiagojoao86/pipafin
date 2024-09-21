import 'package:frontend/model/account_category/account_category_dto.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:frontend/provider/base_provider.dart';
import 'package:frontend/services/account_category_service.dart';

class AccountCategoryProvider extends BaseProvider<AccountCategoryGrid, AccountCategoryDTO> {

  @override
  AccountCategoryService getService() {
    return const AccountCategoryService();
  }

}