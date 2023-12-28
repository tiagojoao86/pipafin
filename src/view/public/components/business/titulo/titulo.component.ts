import { Titulo } from '../../../model/titulo/titulo.model.js';
import { ColumnType } from '../../base/table/column-type.js';
import { TableComponent } from '../../base/table/table.component.js';
import { WidthColumnClass } from '../../base/table/width-column-class.enum.js';
import { TituloDataManager } from './titulo.data-manager.js';
import { TipoTitulo } from '../../../model/titulo/enum/tipo-titulo.enum.js';
import { ModalComponent } from '../../base/modal/modal.component.js';
import { dataManager } from './titulo.module.js';
import { TituloDetail } from './titulo-detail.component.js';
import { BaseComponent } from '../../base/base.component.js';
import { DialogComponent } from '../../base/modal/dialog.component.js';
import { DialogType } from '../../base/modal/dialog-type.js';
import { DialogSeverity } from '../../base/modal/dialog-severity.js';

export class TituloComponent extends BaseComponent {
  table: TableComponent<Titulo>;

  data: Titulo[] = [];

  tituloMain: HTMLElement | null = document.getElementById('titulo-main');

  btnCriar: HTMLElement = document.getElementById('titulos__btn-criar')!;
  btnEditar: HTMLElement = document.getElementById('titulos__btn-editar')!;
  btnExcluir: HTMLElement = document.getElementById('titulos__btn-excluir')!;

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
    super();
    this.table = new TableComponent('titulos__table', this.headers, null, true);
    this.tituloMain?.appendChild(this.table.getTable());
    this.loadInitialData();
    this.btnCriar.addEventListener('click', this.btnCriarClick.bind(this));
    this.btnEditar.addEventListener('click', this.btnEditarClick.bind(this));
    this.btnExcluir.addEventListener('click', this.btnExcluirClick.bind(this));
  }

  btnEditarClick() {
    if (this.table.selectedRows.length > 1) {
      const dialog: DialogComponent = new DialogComponent();
      dialog.openDialog(
        'Informação',
        'Você só pode editar 1 (um) registro por vez.',
        {
          severity: DialogSeverity.INFO,
          type: DialogType.OK,
        }
      );
    }

    if (this.table.selectedRows.length === 0) {
      this.abrirNenhumRegistroSelecionadoDialog();
      return;
    }

    const modal: ModalComponent = new ModalComponent();
    modal.openModal(330, 245, 'titulo/titulo-detail').then(() => {
      const tituloDetail = new TituloDetail(
        this.dataManager,
        this.table.selectedRows[0]
      );
      modal.setContentID(tituloDetail.componentID);
    });
  }

  btnExcluirClick() {
    if (this.table.selectedRows.length === 0) {
      this.abrirNenhumRegistroSelecionadoDialog();
      return;
    }

    if (this.table.selectedRows.length > 0) {
      const dialog: DialogComponent = new DialogComponent();
      dialog.openDialog(
        'Atenção!',
        `Deseja realmente excluir ${this.table.selectedRows.length} registro(s)?`,
        {
          severity: DialogSeverity.WARNING,
          type: DialogType.YES_NO,
          YesOkCb: this.excluirRegistros.bind(this),
        }
      );
    }
  }

  private excluirRegistros(): void {
    this.table.selectedRows.forEach((row) => {
      this.dataManager.removerTitulo(row.id);
      this.table.removeRow(row.id);
    });
  }

  private abrirNenhumRegistroSelecionadoDialog() {
    const dialog: DialogComponent = new DialogComponent();
    dialog.openDialog(
      'Informação',
      'Você precisa selecionar pelo menos 1 (um) registro.',
      {
        severity: DialogSeverity.INFO,
        type: DialogType.OK,
      }
    );
  }

  btnCriarClick() {
    const modal: ModalComponent = new ModalComponent();
    modal.openModal(330, 245, 'titulo/titulo-detail').then((ready) => {
      const tituloDetail = new TituloDetail(this.dataManager);
      modal.setContentID(tituloDetail.componentID);
    });
  }

  async loadInitialData() {
    this.data = await this.dataManager.getTitulo();
    this.table.updateData(this.data);
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

  protected handleMessages(
    message: string,
    payload: any,
    origin: string
  ): void {
    if (message === 'titulo-criado') {
      this.table.appendRow(payload as Titulo);
    }
    if (message === 'titulo-editado') {
      const titulo = payload as Titulo;
      this.table.editRow(titulo.id, titulo);
    }
  }
}

new TituloComponent(dataManager);
