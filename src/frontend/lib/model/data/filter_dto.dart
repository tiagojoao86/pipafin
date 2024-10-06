import 'package:frontend/enumeration/logic_operators_enum.dart';
import 'package:frontend/model/model.dart';

abstract class FilterDTO extends Model {

  LogicOperatorsEnum operator;

  FilterDTO(this.operator);

  Map<String, dynamic> getAttributesMap() {
    Map<String, dynamic> map = {};
    map.putIfAbsent("operator", () => operator.name.toUpperCase());
    return map;
  }
}