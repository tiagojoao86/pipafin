
import 'package:flutter/material.dart';
import 'package:frontend/model/filter/filter_dto.dart';
import 'package:frontend/model/model.dart';
import 'package:frontend/services/base_service.dart';
import 'package:frontend/state/base_state.dart';

abstract class BaseStoreState<G extends Model, D extends Model, F extends FilterDTO> extends ChangeNotifier {
  final BaseService<G,D> service;

  List<G> items = [];

  BaseStoreState(this.service);

  BaseState state = EmptyBaseState();
  
  list(F filter) async {
    state = LoadingBaseState();
    notifyListeners();

    try {
      items = await service.list(filter);
      state = ListedBaseState<G>(items);
      notifyListeners();
    } catch (e) {
      state = ErrorBaseState(e.toString());
      notifyListeners();
    }
  }

  findById(String? id) async {
    state = LoadingBaseState();
    notifyListeners();

    try {
      if (id != null) {
        final result = await service.findById(id);
        state = FoundedBaseState<D>(result);
        notifyListeners();

      } else {
        state = NewRegisterBaseState();
        notifyListeners();
      }
    } catch (e) {
      state = ErrorBaseState(e.toString());
      notifyListeners();
    }
  }

  delete(String id) async {
    state = LoadingBaseState();
    notifyListeners();

    try {
      var deletedId = await service.delete(id);
      var findIndex = items.indexWhere((it) => it.getId() == deletedId);
      if (findIndex != -1) {
        items.removeAt(findIndex);
      }

      state = ListedBaseState(items);
      notifyListeners();
    } catch (e) {
      state = ErrorBaseState(e.toString());
      notifyListeners();
    }
  }

  Future<G?> save(D dto) async {
    state = LoadingBaseState();
    notifyListeners();

    try {
      return await service.save(dto);
    } catch (e) {
      state = ErrorBaseState(e.toString());
      notifyListeners();
      return Future.value();
    }
  }

  updateList(G gridDto) {
    var findIndex = items.indexWhere((it) => it.getId() == gridDto.getId());

    if (findIndex != -1) {
      items[findIndex] = gridDto;
    } else {
      items.add(gridDto);
    }

    state = ListedBaseState(items);
    notifyListeners();
  }
}