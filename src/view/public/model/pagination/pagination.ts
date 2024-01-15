import { IsNumber, IsOptional } from 'class-validator';
import { SortOrder } from './sort-order';

export class Pagination {
  @IsNumber({}, { message: '"page" attribute should be a number' })
  page: number = 0;

  @IsNumber({}, { message: '"pageSize" attribute should be a number' })
  pageSize: number = 5;

  @IsNumber({}, { message: '"totalPages" attribute should be a number' })
  totalPages: number = 0;

  @IsOptional()
  orderBy?: string;

  @IsOptional()
  sortOrder?: SortOrder = SortOrder.DESC;

  constructor(
    page: number,
    pageSize: number,
    totalPages: number,
    orderBy?: string,
    sortOrder?: SortOrder
  ) {
    this.page = page;
    this.pageSize = pageSize;
    this.totalPages = totalPages;
    this.orderBy = orderBy;
    this.sortOrder = sortOrder;
  }
}
