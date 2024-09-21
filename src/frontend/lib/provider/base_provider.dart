import 'package:flutter/material.dart';
import 'package:frontend/model/model.dart';
import 'package:frontend/services/base_service.dart';

abstract class BaseProvider<G extends Model, D extends Model> extends ChangeNotifier {
  List<G> list = [];
  BaseService<G,D>? service;

  BaseProvider() {
    service = getService();
  }

  BaseService<G,D> getService();

  void fetch() async {
    list = await service!.list();
    notifyListeners();
  }

  void updateList(G item) {
    var findIndex = list.indexWhere((it) => it.getId() == item.getId());

    if (findIndex != -1) {
      list[findIndex] = item;
      notifyListeners();
      return;
    }

    list.add(item);
    notifyListeners();
  }

  Future<D> findById(String id) async {
    return await service!.findById(id);
  }

  void save(D dto) async {
    G newItem = await service!.save(dto);
    updateList(newItem);
  }

  void delete(String uuid) async {
    await service!.delete(uuid);
    var findIndex = list.indexWhere((it) => it.getId() == uuid);
    if (findIndex != -1) {
      list.removeAt(findIndex);
      notifyListeners();
    }
  }
}