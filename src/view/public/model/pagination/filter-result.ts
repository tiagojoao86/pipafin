import { Pagination } from './pagination';

export class FilterResult<T> {
  result: T[] = [];
  pagination?: Pagination;

  constructor(result: T[], pagination: Pagination) {
    this.result = result;
    this.pagination = pagination;
  }
}
