import 'package:frontend/model/model.dart';

sealed class BaseState {}

class EmptyBaseState implements BaseState {}

class LoadingBaseState implements BaseState {}

class ErrorBaseState implements BaseState {
  final String message;

  ErrorBaseState(this.message);
}

class FoundedBaseState<D extends Model> implements BaseState {
  final D dto;

  FoundedBaseState(this.dto);
}

class ListedBaseState<G extends Model> implements BaseState {
  List<G> list;
  int totalRegisters;

  ListedBaseState(this.list, this.totalRegisters);
}

class DeletedBaseState implements BaseState {}

class NewRegisterBaseState implements BaseState {

  NewRegisterBaseState();
}