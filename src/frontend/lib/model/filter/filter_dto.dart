import 'package:frontend/enumeration/logic_operators_enum.dart';
import 'package:frontend/model/filter/order.dart';
import 'package:frontend/model/model.dart';

abstract class FilterDTO extends Model {
  LogicOperatorsEnum operator;
  int? pageSize;
  int? pageNumber;
  List<Order>? orders;

  FilterDTO(this.operator);

  Map<String, dynamic> getAttributesMap() {
    Map<String, dynamic> map = {};

    map.putIfAbsent("operator", () => operator.name.toUpperCase());

    if (pageSize != null) {
      map.putIfAbsent("pageSize", () => pageSize);
    }

    if (pageNumber != null) {
      map.putIfAbsent("pageSize", () => pageNumber);
    }

    if (orders != null) {
      List<String> values = orders!.map((it) => it.toJson()).toList();
      map.putIfAbsent("orders", () => values);
    }

    return map;
  }
}