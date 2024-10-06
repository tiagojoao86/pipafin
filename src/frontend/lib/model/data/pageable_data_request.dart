import 'dart:convert';

import 'package:frontend/model/data/filter_dto.dart';
import 'package:frontend/model/data/order.dart';

class PageableDataRequest<F extends FilterDTO> {
  static const String _id = 'id';

  F filter;
  int pageSize = 5;
  int pageNumber = 0;
  List<Order> orders = [Order(SortDirectionEnum.asc, _id)];

  PageableDataRequest(this.filter, this.pageSize, this.pageNumber, this.orders);

  PageableDataRequest.basic(this.filter);

  String toJson() {
    Map<String, dynamic> map = {};
    map.putIfAbsent("filter", () => filter.getAttributesMap());
    map.putIfAbsent("pageSize", () => pageSize);
    map.putIfAbsent("pageNumber", () => pageNumber);
    List<Map<String, dynamic>> values = orders.map((it) => it.toMap()).toList();
    map.putIfAbsent("orders", () => values);

    return jsonEncode(map);
  }


}