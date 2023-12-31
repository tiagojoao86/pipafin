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
import { TituloPagarDto } from 'src/view/public/model/titulo/dto/titulo-pagar.dto.js';

export class TituloComponent extends BaseComponent {
  table: TableComponent<Titulo>;

  data: Titulo[] = [];

  tituloMain: HTMLElement | null = document.getElementById('titulo-main');

  btnCriar: HTMLElement = document.getElementById('titulos__btn-criar')!;
  btnEditar: HTMLElement = document.getElementById('titulos__btn-editar')!;
  btnExcluir: HTMLElement = document.getElementById('titulos__btn-excluir')!;
  btnPagar: HTMLElement = document.getElementById('titulos__btn-pagar')!;

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
    this.btnPagar.addEventListener('click', this.btnPagarClick.bind(this));
  }

  btnPagarClick() {
    if (this.table.selectedRows.length === 0) {
      this.abrirNenhumRegistroSelecionadoDialog();
      return;
    }

    const modal: ModalComponent = new ModalComponent();
    modal.openModal(330, 150, 'titulo/titulo-pagar').then(() => {
      const tituloPagar = new TituloPagar(
        this.dataManager,
        this.table.selectedRows.map((it) => it.id)
      );
      modal.setContentID(tituloPagar.componentID);
    });
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
      return;
    }

    if (this.table.selectedRows.length === 0) {
      this.abrirNenhumRegistroSelecionadoDialog();
      return;
    }

    const modal: ModalComponent = new ModalComponent();
    modal.openModal(330, null, 'titulo/titulo-detail').then(() => {
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
    const ids = this.table.selectedRows.map((row) => row.id);
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

  btnCriarClick() {
    const modal: ModalComponent = new ModalComponent();
    modal.openModal(330, null, 'titulo/titulo-detail').then((ready) => {
      const tituloDetail = new TituloDetail(this.dataManager);
      modal.setContentID(tituloDetail.componentID);
    });
  }

  loadInitialData() {
    this.dataManager.listarTitulo().then((titulos) => {
      this.data = titulos;
      this.table.updateData(this.data);
    });
  }

  dateFormatter(date: Date): string {
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
      this.table.appendRow(payload as Titulo);
    }
    if (message === 'titulo-editado') {
      const titulo = payload as Titulo;
      this.table.editRow(titulo.id, titulo);
    }
    if (message === 'titulo-pagar') {
      const dto = payload as TituloPagarDto;
      const registros = [...this.table.selectedRows]
        .filter((it) => dto.ids.includes(it.id))
        .map((it) => {
          it.dataPagamento = dto.dataPagamento;
          it.situacao = SituacaoTitulo.PAGO;
          return it;
        });
      registros.forEach((item) => this.table.editRow(item.id, item));

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
}

new TituloComponent(dataManager);
