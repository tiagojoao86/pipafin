import { TituloDataManager } from './titulo.data-manager.js';
import { BaseComponent } from '../../base/base.component.js';
import { MessagesControl } from '../../base/messages.component.js';
import { TituloPagarDto } from '../../../model/titulo/dto/titulo-pagar.dto.js';
import { DialogComponent } from '../../base/modal/dialog.component.js';
import { DialogSeverity } from '../../base/modal/dialog-severity.js';
import { DialogType } from '../../base/modal/dialog-type.js';

export class TituloPagar extends BaseComponent {
  btnPagarTitulo: HTMLElement = document.getElementById(
    'titulo-pagar__btn-salvar'
  )!;
  btnCancelar: HTMLElement = document.getElementById(
    'titulo-pagar__btn-cancelar'
  )!;
  tituloPagarForm: HTMLFormElement = document.querySelector('form')!;

  alert = document.getElementById('titulo-pagar__alert');
  message = document.getElementById('titulo-pagar__message');
  btnCloseAlert = document.getElementById('titulo-pagar__close-alert');
  titulosIds?: string[];

  constructor(private dataManager: TituloDataManager, titulosIds?: string[]) {
    super();
    this.addEventListeners();
    this.titulosIds = titulosIds;
    this.populateFormulario();
  }

  populateFormulario(): void {
    for (let i = 0; i < this.tituloPagarForm.elements.length; i++) {
      switch (this.tituloPagarForm.elements[i].getAttribute('name')!) {
        case 'dataPagamento': {
          (this.tituloPagarForm.elements[i] as HTMLInputElement).value =
            new Date().toISOString().split('T')[0];
          break;
        }
      }
    }
  }

  addEventListeners() {
    this.btnPagarTitulo?.addEventListener(
      'click',
      this.pagarTitulos.bind(this)
    );

    this.btnCancelar.addEventListener('click', this.cancelar.bind(this));

    this.btnCloseAlert?.addEventListener(
      'click',
      this.closeAlertLogin.bind(this)
    );
  }

  cancelar(): void {
    this.publishCloseModal();
  }

  pagarTitulos() {
    const formData = new FormData(this.tituloPagarForm);

    if (!this.validarForm(formData)) {
      return;
    }

    this.confirmaPagarTitulos(formData);
  }

  private confirmaPagarTitulos(formData: FormData) {
    const dialog: DialogComponent = new DialogComponent();
    dialog.openDialog(
      'Atenção!',
      `Você deseja registrar o pagamento de ${this.titulosIds?.length} registro(s)?`,
      {
        severity: DialogSeverity.WARNING,
        type: DialogType.YES_NO,
        YesOkCb: this.efetivarPagamento.bind(this, formData),
      }
    );
  }

  private efetivarPagamento(formData: FormData) {
    const dto: TituloPagarDto = {
      ids: this.titulosIds!,
      dataPagamento: new Date(formData.get('dataPagamento') as string),
    };

    this.dataManager.pagarTitulos(dto).then((registros) => {
      MessagesControl.publishMessage(
        'titulo-pagar',
        registros,
        this.componentID
      );
      this.publishCloseModal();
    });
  }

  publishCloseModal() {
    super.unsubscribeMessages();
    MessagesControl.publishMessage('close-modal', null, this.componentID);
  }

  validarForm(formData: FormData): boolean {
    const errors: string[] = [];

    if (isNaN(new Date(formData.get('dataPagamento') as string).getTime()))
      errors.push('A data de pagamento precisa ser válida');

    if (errors.length > 0) {
      this.alert?.classList.remove('hidden');

      if (this.message) this.message.innerHTML = errors.join('<br>');
    }

    return errors.length === 0;
  }

  closeAlertLogin() {
    if (this.message) this.message.innerHTML = '';

    this.alert?.classList.add('hidden');
  }
}
