import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/constants/rest_constants.dart';
import 'package:frontend/model/account_category/account_category_dto.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:frontend/model/account_category/account_category_save.dart';
import 'package:frontend/services/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/model/rresponse.dart';

class AccountCategoryService extends BaseService {

  const AccountCategoryService();

  Future<List<AccountCategoryGrid>> list() async {
    var response = await http.get(getUrl([RestConstants.rAccountCategory]));    
    var responseJson = RResponse<AccountCategoryGrid>.fromJson(response, objCreator: () => AccountCategoryGrid());
    if (responseJson.statusCode == 200) {
      return responseJson.body as List<AccountCategoryGrid>;
    }
    SnackBar(
      content: TextUtil(responseJson.errorMessage),
    );
    throw Exception(responseJson.errorMessage);
  }

  Future<AccountCategoryGrid> save(AccountCategorySave dto) async {
    var response = await http.post(getUrl([RestConstants.rAccountCategory]), body: dto.toJson(), headers: _getHeaders());
    var responseJson = RResponse<AccountCategoryGrid>.fromJson(response, objCreator: () => AccountCategoryGrid());
    if (responseJson.statusCode == 200) {
      return responseJson.body as AccountCategoryGrid;
    }
    SnackBar(
      content: TextUtil(responseJson.errorMessage),
    );
    throw Exception(responseJson.errorMessage);
  }

  Future<String> delete(String uuid) async {
    var response = await http.delete(getUrl([RestConstants.rAccountCategory,'/', uuid]), headers: _getHeaders());
    var responseJson = RResponse<String>.fromJson(response);
    if (responseJson.statusCode == 200) {
      return responseJson.body as String;
    }
    SnackBar(
      content: TextUtil(responseJson.errorMessage),
    );
    throw Exception(responseJson.errorMessage);
  }

  Future<AccountCategoryDTO> findById(String id) async {
    var response = await http.get(getUrl([RestConstants.rAccountCategory, RestConstants.rFindById]), headers: _getHeaders());
    var responseJson = RResponse<AccountCategoryDTO>.fromJson(response, objCreator: () => AccountCategoryDTO.empty());
    if (responseJson.statusCode == 200) {
      return responseJson.body as AccountCategoryDTO;
    }
    SnackBar(
      content: TextUtil(responseJson.errorMessage),
    );
    throw Exception(responseJson.errorMessage);
  }

  Map<String, String> _getHeaders() {
    return <String, String>{
     "Content-type":"application/json"
    };
  }
}