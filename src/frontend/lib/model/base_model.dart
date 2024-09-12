import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class BaseModel<T> {
  String? id;

  BaseModel.empty();

  BaseModel(this.id);

  T fromJson(Map<String, dynamic> map);
  String toJson();
  List<Widget> getInfoList(AppLocalizations? location);
  Future<dynamic> getDetailNavigator(BuildContext context);
  Future<dynamic> getNewNavigator(BuildContext context);
}