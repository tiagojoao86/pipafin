import { CriarTituloDto } from 'src/view/public/model/titulo/dto/criar-titulo.dto';
import { TituloDataManager } from './titulo.data-manager';
import { TipoTitulo } from 'src/view/public/model/titulo/enum/tipo-titulo.enum';
import { BaseComponent } from '../../base/base.component.js';
import { MessagesControl } from '../../base/messages.component.js';
import { dataManager } from './titulo.module.js';

export class TituloDetail extends BaseComponent {
  btnSalvarTitulo: HTMLElement = document.getElementById('btnSalvarTitulo')!;
  btnCancelarEdicao: HTMLElement =
    document.getElementById('btnCancelarEdicao')!;
  tituloDetail: HTMLFormElement = document.querySelector('form')!;
  inputValorTitulo: HTMLInputElement = document.getElementById(
    'inputValorTitulo'
  )! as HTMLInputElement;

  alert = document.getElementById('alertTituloDetail');
  message = document.getElementById('messageTituloDetail');
  btnCloseAlertTituloDetail = document.getElementById('closeAlertTituloDetail');

  constructor(private dataManager: TituloDataManager) {
    super();
    this.addEventListeners();
  }

  addEventListeners() {
    this.btnSalvarTitulo?.addEventListener(
      'click',
      this.salvarTitulo.bind(this)
    );
    this.inputValorTitulo.addEventListener(
      'keyup',
      this.formatMoney.bind(this)
    );

    this.btnCancelarEdicao.addEventListener(
      'click',
      this.cancelarEdicao.bind(this)
    );

    this.btnCloseAlertTituloDetail?.addEventListener(
      'click',
      this.closeAlertLogin.bind(this)
    );
  }

  cancelarEdicao(): void {
    this.publishCloseModal();
  }

  formatMoney($event: any) {
    if (
      $event.key.match(/[^\d|\,]/g) &&
      $event.key !== 'Backspace' &&
      $event.key !== 'Delete'
    ) {
      this.inputValorTitulo.value = this.inputValorTitulo.value.replace(
        /[^\d|\,]/g,
        ''
      );
    } else {
      if (this.inputValorTitulo.value.length > 2) {
        let value = this.inputValorTitulo.value;
        value = value.replace(',', '');

        const decimal = value.substring(value.length - 2, value.length);
        let inteiro = value.substring(0, value.length - 2);

        if (inteiro === '') inteiro = '0';

        this.inputValorTitulo.value = inteiro + ',' + decimal;
      }
    }
  }

  salvarTitulo() {
    const formData = new FormData(this.tituloDetail);

    let criarTitulo: CriarTituloDto;

    if (this.validarForm(formData)) {
      criarTitulo = {
        numero: formData.get('numero') as string,
        valor: +(formData.get('valor') as string).replace(',', '.'),
        descricao: formData.get('descricao') as string,
        tipo: formData.get('tipo') as TipoTitulo,
        dataVencimento: new Date(formData.get('dataVencimento') as string),
      };
    } else {
      return;
    }

    this.dataManager.salvarTitulo(criarTitulo).then((titulo) => {
      MessagesControl.publishMessage('titulo-salvo', titulo, this.componentID);
      this.publishCloseModal();
    });
  }

  publishCloseModal() {
    super.unsubscribeMessages();
    MessagesControl.publishMessage('close-modal', null, this.componentID);
  }

  validarForm(formData: FormData): boolean {
    const errors: string[] = [];

    if ((formData.get('numero') as string).length === 0)
      errors.push('O número não pode ser vazio');

    if ((formData.get('valor') as string).length === 0)
      errors.push('O valor não pode ser vazio');

    if ((formData.get('descricao') as string).length === 0)
      errors.push('A descrição não pode ser vazia');

    if (isNaN(new Date(formData.get('dataVencimento') as string).getTime()))
      errors.push('A data de vencimento precisa ser válida');

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
