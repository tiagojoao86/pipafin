import 'dart:convert';

class Order {
  SortDirectionEnum direction;
  String property;

  Order(this.direction, this.property);

  String toJson() {
    Map<String, dynamic> map = {};

    map.putIfAbsent("direction", () => direction.name.toUpperCase());
    map.putIfAbsent("property", () => property);

    return jsonEncode(map);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map.putIfAbsent("direction", () => direction.name.toUpperCase());
    map.putIfAbsent("property", () => property);

    return map;
  }
}

enum SortDirectionEnum {
  asc,
  desc
}