import 'package:frontend/model/account_category/account_category_dto.dart';
import 'package:frontend/model/account_category/account_category_filter_dto.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:frontend/services/account_category_service.dart';
import 'package:frontend/state/base_store_state.dart';

class AccountCategoryStoreState extends BaseStoreState<AccountCategoryGrid, AccountCategoryDTO, AccountCategoryFilterDTO> {
  AccountCategoryStoreState() : super(const AccountCategoryService());
}