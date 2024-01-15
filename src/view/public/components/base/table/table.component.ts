import { Pagination } from 'src/view/public/model/pagination/pagination';
import { ColumnType } from './column-type';

export class TableComponent<E> {
  private columns: ColumnType[];
  private data: E[] | null;
  private selectedRows: E[];
  private tableEl = document.createElement('table');
  private tbodyEl = document.createElement('tbody');
  private theadEl = document.createElement('thead');
  private tfootEl = document.createElement('tfoot');
  private hasRowSelector: boolean;
  private totalPages: number = 1;
  private currentPage: number = 1;
  private pageData = document.createElement('span');
  private readonly ID_CHECKBOX_HEADER = '0';

  private changeItemsPerPageFunction: Function = () => {};
  private changePageFunction: Function = () => {};

  private NEXT_PAGE: HTMLLIElement = document.createElement('li');
  private PREVIOUS_PAGE: HTMLLIElement = document.createElement('li');
  private LAST_PAGE: HTMLLIElement = document.createElement('li');
  private FIRST_PAGE: HTMLLIElement = document.createElement('li');

  private paginationOptions: string[] = ['5', '10', '25', '50'];

  constructor(
    id: string,
    columns: ColumnType[],
    data: E[] | null,
    hasRowSelector: boolean = true
  ) {
    this.columns = columns;
    this.data = data;
    this.selectedRows = [];
    this.hasRowSelector = hasRowSelector;
    this.tableEl.id = id;

    this.validateColumns();

    this.organizeChilds();
    this.applyInitialClasses();
    this.buildHeaders();
    this.buildFooter();
  }

  public setPaginationOptions(list: string[]) {
    this.paginationOptions = list;
  }

  public getTable(): HTMLElement {
    return this.tableEl;
  }

  public getData() {
    return this.data;
  }

  public updateData(data: E[], pagination: Pagination) {
    this.removeAllData();
    this.data = data;
    this.populateTable();
    this.updatePageNumbers(pagination.page, pagination.totalPages);
  }

  public appendRow(item: E) {
    this.tbodyEl.appendChild(this.createRow(item));
    this.data?.push(item);
  }

  public editRow(itemId: string, item: E) {
    this.removeRows([itemId]);
    this.appendRow(item);
    this.selectedRows = [];
  }

  public removeRows(itemsIds: string[]) {
    const columnId: any = this.columns.find((column) => column.isId);
    const rows = this.tbodyEl.getElementsByTagName('TR');

    for (let i = 0; i < rows.length; i++) {
      if (itemsIds.includes(rows[i].getAttribute(columnId.dataAttribute)!)) {
        const child = this.tbodyEl.children.item(i);
        if (child) this.tbodyEl.removeChild(child);
      }
    }

    this.selectedRows = [];
  }

  private organizeChilds(): void {
    this.tableEl.appendChild(this.theadEl);
    this.tableEl.appendChild(this.tbodyEl);
    this.tableEl.appendChild(this.tfootEl);
  }

  private applyInitialClasses(): void {
    this.tableEl.classList.add('table');
  }

  private removeAllData(): void {
    this.data = [];
    this.tbodyEl.innerHTML = '';
  }

  /** Populates table */
  private populateTable(): void {
    this.data?.forEach((item: any) => {
      this.tbodyEl.appendChild(this.createRow(item));
    });
  }

  private createRow(item: E): HTMLTableRowElement {
    const trEl = document.createElement('tr');

    this.verifyAndCreateRowSelector(item, trEl);

    this.columns.forEach((header) => {
      this.createDataRow(item, header, trEl);
    });

    return trEl;
  }

  /** Creates rows with data */
  private createDataRow(item: any, header: any, trEl: HTMLElement): void {
    const attribute = item[header.dataAttribute];
    const thEl = document.createElement('th');

    if (header.isId) trEl.id = item[header.dataAttribute];
    if (header.hidden) thEl.style.display = 'none';

    thEl.innerHTML = header.formatter
      ? header.formatter.call(this, attribute)
      : attribute;
    trEl.appendChild(thEl);
  }

  /** Creates the row selector (checkbox) if hasRowSelector true */
  private verifyAndCreateRowSelector(item: any, trEl: HTMLElement): void {
    if (this.hasRowSelector) {
      const columnId: any = this.columns.find((column) => column.isId);
      if (columnId) {
        trEl.appendChild(
          this.buildCheckboxSelector(item[columnId.dataAttribute])
        );
      }
    }
  }

  /** Build the headers of the table with columns data */
  private buildHeaders(): void {
    const trEl = document.createElement('tr');

    if (this.hasRowSelector) {
      trEl.appendChild(this.buildCheckboxSelector(this.ID_CHECKBOX_HEADER));
    }

    this.columns.forEach((column) => {
      const th = document.createElement('th');
      th.classList.add(column.widthClass);
      th.innerText = column.header;

      if (column.hidden) th.style.display = 'none';

      trEl.appendChild(th);
    });

    this.theadEl.appendChild(trEl);
  }

  /** Build the checkbox element for row selector */
  private buildCheckboxSelector(id: any): HTMLTableCellElement {
    const th = document.createElement('th');
    th.classList.add('w-00');
    const checkbox = document.createElement('input');
    checkbox.id = id;

    checkbox.setAttribute('type', 'checkbox');
    checkbox.setAttribute('rowSelector', 'true');

    checkbox.addEventListener('change', this.checkboxEventListener.bind(this));

    th.appendChild(checkbox);

    return th;
  }

  /** Event that fires when the checkbox (row selector) value changes */
  private checkboxEventListener(e: any) {
    if (e.target.id === this.ID_CHECKBOX_HEADER) {
      this.selectAllRows(e.target.checked);
    } else {
      this.selectRow(e.target.id, e.target.checked);
    }
  }

  /** when was selected 1 row, this method is call */
  public selectRow(id: any, wasSelected: boolean): void {
    const columnId: any = this.columns.find((column) => column.isId);
    if (columnId) {
      if (wasSelected) {
        const item = this.data?.find(
          (el: any) => el[columnId.dataAttribute] === id
        );
        if (item) {
          this.selectedRows?.push(item);
        }
      } else {
        const itemIndex = this.selectedRows?.findIndex(
          (el: any) => el[columnId.dataAttribute] === id
        )!;
        if (itemIndex != -1) {
          this.selectedRows?.splice(itemIndex, 1);
        }
      }
    }
  }

  /** when was select all rows, this method is call */
  private selectAllRows(wasSelected: boolean): void {
    this.changeAllCheckboxes(wasSelected);
    if (wasSelected) {
      this.selectedRows = Object.assign([], this.data);
    } else {
      this.selectedRows = [];
    }
  }

  /** this method change the state of all checkboxes */
  private changeAllCheckboxes(state: boolean): void {
    const checkboxList = this.tbodyEl.querySelectorAll(
      "input[rowSelector='true']"
    );
    checkboxList.forEach((checkboxEl: any) => {
      checkboxEl.checked = state;
    });
  }

  /** builds the footer (pagination) */
  private buildFooter(): void {
    const tdEl = document.createElement('td');
    tdEl.setAttribute('colspan', this.columns.length + '');
    const div = document.createElement('div');

    div.appendChild(this.buildPaginationList());
    div.appendChild(this.buildItemPerPageSelector());
    tdEl.appendChild(div);
    this.tfootEl.appendChild(tdEl);
  }

  private buildPaginationList(): HTMLUListElement {
    const ulEl = document.createElement('ul');

    ulEl.appendChild(
      this.buildItemPagination('<<', this.firstPage, this.FIRST_PAGE)
    );
    ulEl.appendChild(
      this.buildItemPagination('<', this.previousPage, this.PREVIOUS_PAGE)
    );
    ulEl.appendChild(this.getElementPageNumbers());
    ulEl.appendChild(
      this.buildItemPagination('>', this.nextPage, this.NEXT_PAGE)
    );
    ulEl.appendChild(
      this.buildItemPagination('>>', this.lastPage, this.LAST_PAGE)
    );

    return ulEl;
  }

  private buildItemPerPageSelector(): HTMLDivElement {
    const div = document.createElement('div');
    div.classList.add('item-per-page');
    const select = document.createElement('select');
    this.buildOptionsPerPageSelector().forEach((option) =>
      select.appendChild(option)
    );

    select.addEventListener(
      'change',
      this.changeItemsPerPageQuantity.bind(this)
    );

    const label = document.createElement('label');
    label.innerHTML = 'Itens';
    div.appendChild(select);
    div.appendChild(label);

    return div;
  }

  private buildOptionsPerPageSelector(): HTMLOptionElement[] {
    const items: HTMLOptionElement[] = [];

    this.paginationOptions.forEach((item) => {
      const option = document.createElement('option');
      option.setAttribute('value', item);
      option.innerHTML = item;
      items.push(option);
    });

    return items;
  }

  private buildItemPagination(
    icon: string,
    clickEvent: Function,
    liEl: HTMLLIElement
  ): HTMLElement {
    liEl = document.createElement('li');

    const spanEl = document.createElement('span');
    spanEl.innerHTML = icon;
    spanEl.addEventListener('click', clickEvent.bind(this));

    liEl.appendChild(spanEl);

    return liEl;
  }

  private updatePageNumbers(currentPage: number, totalPages: number) {
    this.currentPage = currentPage;
    this.totalPages = totalPages;
    this.updatePageData();
  }

  private getElementPageNumbers() {
    const liEl = document.createElement('li');
    liEl.style.cursor = 'default';
    liEl.style.pointerEvents = 'none';
    liEl.appendChild(this.pageData);

    this.updatePageData();

    return liEl;
  }

  private updatePageData(): void {
    this.pageData.innerHTML = `${this.currentPage + 1} de ${this.totalPages}`;
  }

  private validateColumns(): boolean {
    const columnId = this.columns.filter((col) => col.isId);

    if (columnId.length < 1)
      throw new Error(`One column needs to be flagged with "isId"`);
    if (columnId.length > 1)
      throw new Error(`Only one column can be flagged with "isId"`);

    return true;
  }

  public getSelectedRows(): E[] {
    return this.selectedRows;
  }

  public setChangeItemsPerPageCallback(cb: Function): void {
    this.changeItemsPerPageFunction = cb;
  }

  public setChangePageCallback(cb: Function): void {
    this.changePageFunction = cb;
  }

  private changeItemsPerPageQuantity($event: any): void {
    this.changeItemsPerPageFunction.call(this, $event.target.value);
  }

  private nextPage() {
    if (this.currentPage + 1 === this.totalPages) return;

    this.changePageFunction.call(this, this.currentPage + 1);
  }

  private previousPage() {
    if (this.currentPage === 0) return;

    this.changePageFunction.call(this, this.currentPage - 1);
  }

  private firstPage() {
    this.currentPage = 0;
    this.changePageFunction.call(this, this.currentPage);
  }

  private lastPage() {
    this.currentPage = this.totalPages - 1;
    this.changePageFunction.call(this, this.currentPage);
  }
}
