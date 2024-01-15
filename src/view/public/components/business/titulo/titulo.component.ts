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
import { TituloPagar } from './titulo-pagar.component.js';
import { SituacaoTitulo } from '../../../model/titulo/enum/situacao-titulo.enum.js';
import { TituloPagarDto } from '../../../model/titulo/dto/titulo-pagar.dto.js';
import { FiltrarTituloDTO } from '../../../model/titulo/dto/filtrar-titulo.js';
import { SortOrder } from '../../../model/pagination/sort-order.js';

export class TituloComponent extends BaseComponent {
  private table: TableComponent<Titulo>;

  private data: Titulo[] = [];
  private filtro: FiltrarTituloDTO = {
    page: 0,
    pageSize: 5,
    totalPages: 0,
    orderBy: 'numero',
    sortOrder: SortOrder.ASC,
  };

  private modal: ModalComponent = new ModalComponent();

  private tituloMain: HTMLElement | null =
    document.getElementById('titulo-main');

  private btnCriar: HTMLElement =
    document.getElementById('titulos__btn-criar')!;

  private btnEditar: HTMLElement = document.getElementById(
    'titulos__btn-editar'
  )!;

  private btnExcluir: HTMLElement = document.getElementById(
    'titulos__btn-excluir'
  )!;

  private btnPagar: HTMLElement =
    document.getElementById('titulos__btn-pagar')!;

  private headers: ColumnType[] = [
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
    this.assingTableCallBackFunctions();
    this.tituloMain?.appendChild(this.table.getTable());
    this.loadInitialData();
    this.btnCriar.addEventListener('click', this.btnCriarClick.bind(this));
    this.btnEditar.addEventListener('click', this.btnEditarClick.bind(this));
    this.btnExcluir.addEventListener('click', this.btnExcluirClick.bind(this));
    this.btnPagar.addEventListener('click', this.btnPagarClick.bind(this));
  }

  private assingTableCallBackFunctions(): void {
    this.table.setChangeItemsPerPageCallback(
      this.changeItemsPerPage.bind(this)
    );
    this.table.setChangePageCallback(this.changePage.bind(this));
  }

  private changeItemsPerPage(newPageSize: number): void {
    this.filtro.pageSize = newPageSize;
    this.filtrar();
  }

  private changePage(newPage: number): void {
    this.filtro.page = newPage;
    this.filtrar();
  }

  private btnPagarClick(): void {
    if (this.table.getSelectedRows().length === 0) {
      this.abrirNenhumRegistroSelecionadoDialog();
      return;
    }

    this.modal.openModal(330, 150, 'titulo/titulo-pagar').then(() => {
      new TituloPagar(
        this.dataManager,
        this.table.getSelectedRows().map((it) => it.id)
      );
    });
  }

  private btnEditarClick(): void {
    if (this.table.getSelectedRows().length > 1) {
      const dialog: DialogComponent = new DialogComponent();
      dialog.openDialog(
        'Informação',
        'Você só pode editar 1 (um) registro por vez.',
        {
          severity: DialogSeverity.INFO,
          type: DialogType.OK,
        }
      );
      return;
    }

    if (this.table.getSelectedRows().length === 0) {
      this.abrirNenhumRegistroSelecionadoDialog();
      return;
    }

    this.modal.openModal(330, null, 'titulo/titulo-detail').then(() => {
      new TituloDetail(this.dataManager, this.table.getSelectedRows()[0]);
    });
  }

  private btnExcluirClick(): void {
    if (this.table.getSelectedRows().length === 0) {
      this.abrirNenhumRegistroSelecionadoDialog();
      return;
    }

    if (this.table.getSelectedRows().length > 0) {
      const dialog: DialogComponent = new DialogComponent();
      dialog.openDialog(
        'Atenção!',
        `Deseja realmente excluir ${
          this.table.getSelectedRows().length
        } registro(s)?`,
        {
          severity: DialogSeverity.WARNING,
          type: DialogType.YES_NO,
          YesOkCb: this.excluirRegistros.bind(this),
        }
      );
    }
  }

  private excluirRegistros(): void {
    const ids = this.table.getSelectedRows().map((row) => row.id);
    this.dataManager.removerTitulo(ids).then((titulosRemovidos) => {
      const dialog: DialogComponent = new DialogComponent();
      dialog.openDialog(
        'Informação',
        `Total de registros removidos: ${titulosRemovidos}`,
        {
          severity: DialogSeverity.INFO,
          type: DialogType.OK,
        }
      );
      this.table.removeRows(ids);
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

  private btnCriarClick(): void {
    this.modal.openModal(330, null, 'titulo/titulo-detail').then((ready) => {
      new TituloDetail(this.dataManager);
    });
  }

  private loadInitialData(): void {
    this.filtrar();
  }

  private filtrar(): void {
    this.dataManager.filtrarTitulo(this.filtro).then((result) => {
      this.data = result.result;
      if (result.pagination) {
        this.filtro.page = result.pagination.page;
        this.filtro.pageSize = result.pagination.pageSize;
        this.filtro.totalPages = result.pagination.totalPages;
        this.filtro.orderBy = result.pagination.orderBy;
        this.filtro.sortOrder = result.pagination.sortOrder;
      }
      this.table.updateData(this.data, this.filtro);
    });
  }

  private dateFormatter(date: Date): string {
    if (date) {
      return new Intl.DateTimeFormat(navigator.language, {
        day: 'numeric',
        month: 'numeric',
        year: 'numeric',
        timeZone: 'UTC',
      }).format(new Date(date));
    }

    return '';
  }

  private moneyFormatter(money: number): string {
    if (money) {
      return new Intl.NumberFormat(navigator.language, {
        style: 'currency',
        currency: 'BRL',
      }).format(money);
    }

    return '';
  }

  private tipoFormatter(tipo: TipoTitulo): string {
    if (tipo) {
      const color = tipo === TipoTitulo.PAGAR ? 'red' : 'green';
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
      this.tituloCriado(payload);
    }
    if (message === 'titulo-editado') {
      this.tituloEditado(payload);
    }
    if (message === 'titulo-pagar') {
      this.tituloPagar(payload);
    }
    if (message === 'cancelar-edicao') {
      this.modal.closeModal();
    }
  }

  private tituloCriado(titulo: Titulo): void {
    this.table.appendRow(titulo);
    this.modal.closeModal();
  }

  private tituloEditado(titulo: Titulo): void {
    this.table.editRow(titulo.id, titulo);
    this.modal.closeModal();
  }

  private tituloPagar(dto: TituloPagarDto): void {
    const registros = [...this.table.getSelectedRows()]
      .filter((it) => dto.ids.includes(it.id))
      .map((it) => {
        it.dataPagamento = dto.dataPagamento;
        it.situacao = SituacaoTitulo.PAGO;
        return it;
      });
    registros.forEach((item) => this.table.editRow(item.id, item));

    this.modal.closeModal();

    const dialog: DialogComponent = new DialogComponent();
    dialog.openDialog(
      'Informação',
      `Registros modificados: ${registros.length}.`,
      {
        severity: DialogSeverity.INFO,
        type: DialogType.OK,
      }
    );
  }
}

new TituloComponent(dataManager);
