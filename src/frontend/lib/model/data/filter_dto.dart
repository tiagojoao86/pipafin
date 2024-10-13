import 'package:frontend/enumeration/logic_operators_enum.dart';
import 'package:frontend/model/model.dart';

abstract class FilterDTO extends Model {

  LogicOperatorsEnum operator;

  FilterDTO(this.operator);

  Map<String, dynamic> getAttributesMap();
}