import 'dart:convert';

import 'package:frontend/constants/configuration_constants.dart';
import 'package:frontend/model/data/filter_dto.dart';
import 'package:frontend/model/data/sort.dart';

class PageableDataRequest<F extends FilterDTO> {
  static const String _id = 'ID';

  F filter;
  int pageSize = ConfigurationConstants.pageSizeDefault;
  int pageNumber = 0;
  List<Sort> sort = [];

  PageableDataRequest(this.filter, this.pageSize, this.pageNumber, this.sort);

  PageableDataRequest.basic(this.filter);

  String toJson() {
    Map<String, dynamic> map = {};
    map.putIfAbsent("filter", () => filter.getAttributesMap());
    map.putIfAbsent("pageSize", () => pageSize);
    map.putIfAbsent("pageNumber", () => pageNumber);
    List<Map<String, dynamic>> values = sort.map((it) => it.toMap()).toList();
    map.putIfAbsent("sort", () => values);

    return jsonEncode(map);
  }


}