import { Titulo } from 'src/view/public/model/titulo/titulo.model.js';
import { ColumnType } from '../../base/table/column-type.js';
import { TableComponent } from '../../base/table/table.component.js';
import { WidthColumnClass } from '../../base/table/width-column-class.enum.js';
import { TituloDataManager } from './titulo.data-manager.js';
import { TipoTitulo } from '../../../model/titulo/enum/tipo-titulo.enum.js';
import { ModalComponent } from '../../base/modal/modal.component.js';

export class TituloComponent {
  table: TableComponent<Titulo>;

  tituloMain: HTMLElement | null = document.getElementById('titulo-main');

  btnCriar: HTMLElement | null = document.getElementById('titulos__btn-criar');

  headers: ColumnType[] = [
    {
      header: 'Id',
      widthClass: WidthColumnClass.W05,
      dataAttribute: 'id',
      hidden: true,
      isId: true,
    },
    {
      header: 'Número',
      widthClass: WidthColumnClass.W05,
      dataAttribute: 'numero',
    },
    {
      header: 'Descrição',
      widthClass: WidthColumnClass.W15,
      dataAttribute: 'descricao',
    },
    {
      header: 'Tipo',
      widthClass: WidthColumnClass.W10,
      dataAttribute: 'tipo',
      formatter: this.tipoFormatter.bind(this),
    },
    {
      header: 'Situação',
      widthClass: WidthColumnClass.W10,
      dataAttribute: 'situacao',
    },
    {
      header: 'Valor',
      widthClass: WidthColumnClass.W10,
      dataAttribute: 'valor',
      formatter: this.moneyFormatter.bind(this),
    },
    {
      header: 'Data Vcto',
      widthClass: WidthColumnClass.W10,
      dataAttribute: 'dataVencimento',
      formatter: this.dateFormatter.bind(this),
    },
    {
      header: 'Data Pagto',
      widthClass: WidthColumnClass.W10,
      dataAttribute: 'dataPagamento',
      formatter: this.dateFormatter.bind(this),
    },
  ];

  constructor(private dataManager: TituloDataManager) {
    this.table = new TableComponent('titulos__table', this.headers, null, true);
    this.tituloMain?.appendChild(this.table.getTable());
    this.loadInitialData();
    this.btnCriar?.addEventListener('click', this.btnCriarClick.bind(this));
  }

  btnCriarClick() {
    const modal: ModalComponent = new ModalComponent(370, 290, '/titulos/new');
    modal.openModal();
  }

  async loadInitialData() {
    const data = await this.dataManager.getTitulo();
    this.table.updateData(data);
  }

  dateFormatter(date: Date): string {
    if (date) {
      return new Intl.DateTimeFormat(navigator.language, {
        day: 'numeric',
        month: 'numeric',
        year: 'numeric',
      }).format(new Date(date));
    }

    return '';
  }

  moneyFormatter(money: number): string {
    if (money) {
      return new Intl.NumberFormat(navigator.language, {
        style: 'currency',
        currency: 'BRL',
      }).format(money);
    }

    return '';
  }

  tipoFormatter(tipo: TipoTitulo): string {
    if (tipo) {
      const color = tipo === TipoTitulo.PAGAR ? 'green' : 'red';
      return `<p style="color: ${color}; margin: 0px">${tipo}</p>`;
    }

    return '';
  }
}

new TituloComponent(new TituloDataManager());
