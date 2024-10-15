import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/l10n/l10n_service.dart';

class Sort {
  SortDirectionEnum direction;
  Property property;

  Sort(this.direction, this.property);

  String toJson() {
    Map<String, dynamic> map = {};

    map.putIfAbsent("direction", () => direction.name.toUpperCase());
    map.putIfAbsent("property", () => property.name);

    return jsonEncode(map);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map.putIfAbsent("direction", () => direction.name.toUpperCase());
    map.putIfAbsent("property", () => property.name);

    return map;
  }

  @override
  bool operator ==(Object other) =>
      other is Sort &&
          other.runtimeType == runtimeType &&
          other.property.name == property.name;

  @override
  int get hashCode => property.name.hashCode;
}

class Property {
  String label;
  String name;

  Property(this.label, this.name);
}

enum SortDirectionEnum {
  asc,
  desc;

  static List<DropdownMenuItem<SortDirectionEnum>> getDropdownList() {
    List<DropdownMenuItem<SortDirectionEnum>> list = [];

    for (SortDirectionEnum item in values) {
      list.add(
        DropdownMenuItem<SortDirectionEnum>(
          value: item,
          child: Text(L10nService.l10n().sortDirection(item.name)),
        ),
      );
    }

    return list;
  }
}
