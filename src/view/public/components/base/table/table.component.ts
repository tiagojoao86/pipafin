import { ColumnType } from './column-type';

export class TableComponent<E> {
  columns: ColumnType[];
  data: E[] | null;
  selectedRows: E[];
  divMainEl = document.createElement('div');
  divTable = document.createElement('div');
  divPagination = document.createElement('div');
  tableEl = document.createElement('table');
  tbodyEl = document.createElement('tbody');
  theadEl = document.createElement('thead');
  tfootEl = document.createElement('tfoot');
  paginationEl = document.createElement('nav');
  hasRowSelector: boolean;
  totalPages: number = 1;
  currentPage: number = 1;
  readonly ID_CHECKBOX_HEADER = '0';

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

    this.organizeChilds();
    this.applyInitialClasses();
    this.buildHeaders();
    this.buildFooter();
    this.buildDivPagination();
  }

  public getTable(): HTMLElement {
    return this.divMainEl;
  }

  public getData() {
    return this.data;
  }

  public updateData(data: E[]) {
    this.data = data;
    this.populateTable();
  }

  public appendRow(item: E) {
    this.tbodyEl.appendChild(this.createRow(item));
    this.data?.push(item);
  }

  public removeRow(itemId: string) {
    const rows = this.tbodyEl.getElementsByTagName('TR');

    for (let i = 0; i < rows.length; i++) {
      if (rows[i].getAttribute('id') === itemId) {
        const child = this.tbodyEl.children.item(i);
        if (child) this.tbodyEl.removeChild(child);
      }
    }
  }

  private organizeChilds(): void {
    this.divTable.appendChild(this.tableEl);
    this.divPagination.appendChild(this.paginationEl);
    this.divMainEl.appendChild(this.divTable);
    this.divMainEl.appendChild(this.divPagination);
    this.tableEl.appendChild(this.theadEl);
    this.tableEl.appendChild(this.tbodyEl);
    this.tableEl.appendChild(this.tfootEl);
  }

  private applyInitialClasses(): void {
    this.divMainEl.classList.add('div-main-table');
    this.tableEl.classList.add('table');
    this.divPagination.classList.add('table');
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
        const itemIndex = this.data?.findIndex(
          (el: any) => el[columnId] === id
        );
        if (itemIndex) {
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
  private buildFooter(): void {}

  private buildDivPagination() {
    const ulEl = document.createElement('ul');

    ulEl.appendChild(this.buildItemPagination('<<', this.firstPage));
    ulEl.appendChild(this.buildItemPagination('<', this.previousPage));
    ulEl.appendChild(this.getElementPageNumbers());
    ulEl.appendChild(this.buildItemPagination('>', this.nextPage));
    ulEl.appendChild(this.buildItemPagination('>>', this.lastPage));

    this.paginationEl.appendChild(ulEl);
  }

  private buildItemPagination(icon: string, clickEvent: Function): HTMLElement {
    const liEl = document.createElement('li');

    const spanEl = document.createElement('span');
    spanEl.innerHTML = icon;
    spanEl.addEventListener('click', clickEvent.bind(this));

    liEl.appendChild(spanEl);

    return liEl;
  }

  private nextPage() {
    console.log('nextPage');
  }

  private previousPage() {
    console.log('previousPage');
  }

  private firstPage() {
    console.log('firstPage');
  }

  private lastPage() {
    console.log('lastPage');
  }

  private updatePageNumbers(currentPage: number, totalPages: number) {
    this.currentPage = currentPage;
    this.totalPages = totalPages;
  }

  private getElementPageNumbers() {
    const liEl = document.createElement('li');
    const spanEl = document.createElement('span');
    liEl.style.cursor = 'default';
    liEl.style.pointerEvents = 'none';
    spanEl.innerHTML = `${this.currentPage} de ${this.totalPages}`;

    liEl.appendChild(spanEl);

    return liEl;
  }
}
