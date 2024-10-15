import 'package:frontend/enumeration/logic_operators_enum.dart';

abstract class FilterDTO {

  LogicOperatorsEnum operator;

  FilterDTO(this.operator);

  Map<String, dynamic> getAttributesMap();

  String toJson();
}