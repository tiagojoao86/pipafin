import 'package:frontend/model/base_dto.dart';
import 'package:frontend/model/base_grid_dto.dart';

sealed class BaseState {}

class EmptyBaseState implements BaseState {}

class LoadingBaseState implements BaseState {}

class ErrorBaseState implements BaseState {
  final String message;

  ErrorBaseState(this.message);
}

class FoundedBaseState<D extends BaseDTO> implements BaseState {
  final D dto;

  FoundedBaseState(this.dto);
}

class ListedBaseState<G extends BaseGridDTO> implements BaseState {
  List<G> list;
  int totalRegisters;

  ListedBaseState(this.list, this.totalRegisters);
}

class DeletedBaseState implements BaseState {}

class NewRegisterBaseState implements BaseState {

  NewRegisterBaseState();
}