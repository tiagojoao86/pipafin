class PageableDataResponse<T> {
  List<T> data;
  int totalRegisters;

  PageableDataResponse(this.data, this.totalRegisters);
}