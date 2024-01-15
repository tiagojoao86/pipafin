import { CriarTituloDto } from '../../../model/titulo/dto/criar-titulo.dto.js';
import { TituloDataManager } from './titulo.data-manager.js';
import { TipoTitulo } from '../../../model/titulo/enum/tipo-titulo.enum.js';
import { BaseComponent } from '../../base/base.component.js';
import { MessagesControl } from '../../base/messages.component.js';
import { Titulo } from '../../../model/titulo/titulo.model.js';
import { EditarTituloDto } from '../../../model/titulo/dto/editar-titulo.dto.js';
import { SituacaoTitulo } from 'src/view/public/model/titulo/enum/situacao-titulo.enum.js';

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
  titulo?: Titulo;

  constructor(private dataManager: TituloDataManager, titulo?: Titulo) {
    super();
    this.addEventListeners();
    this.titulo = titulo;
    this.populateFormulario();
  }

  populateFormulario(): void {
    if (this.titulo) {
      for (let i = 0; i < this.tituloDetail.elements.length; i++) {
        switch (this.tituloDetail.elements[i].getAttribute('name')!) {
          case 'numero': {
            (this.tituloDetail.elements[i] as HTMLInputElement).value =
              this.titulo.numero;
            break;
          }
          case 'valor': {
            (this.tituloDetail.elements[i] as HTMLInputElement).value = (
              '' + this.titulo.valor
            ).replace('.', ',');
            break;
          }
          case 'descricao': {
            (this.tituloDetail.elements[i] as HTMLInputElement).value =
              this.titulo.descricao;
            break;
          }
          case 'tipo': {
            (this.tituloDetail.elements[i] as HTMLInputElement).value =
              this.titulo.tipo;
            break;
          }
          case 'dataVencimento': {
            (this.tituloDetail.elements[i] as HTMLInputElement).value =
              new Date(this.titulo.dataVencimento).toISOString().split('T')[0];
            break;
          }
          case 'dataPagamento': {
            if (this.titulo.dataPagamento)
              (this.tituloDetail.elements[i] as HTMLInputElement).value =
                new Date(this.titulo.dataPagamento).toISOString().split('T')[0];

            break;
          }
          case 'situacao': {
            (this.tituloDetail.elements[i] as HTMLInputElement).value =
              this.titulo.situacao;
            break;
          }
        }
      }
    }
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
    MessagesControl.publishMessage('cancelar-edicao', null, this.componentID);
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

    if (!this.validarForm(formData)) {
      return;
    }

    if (this.titulo) this.editarTitulo(formData);
    else this.novoTitulo(formData);
  }

  private editarTitulo(formData: FormData) {
    let tituloEditado: EditarTituloDto;

    tituloEditado = {
      numero: formData.get('numero') as string,
      valor: +(formData.get('valor') as string).replace(',', '.'),
      descricao: formData.get('descricao') as string,
      tipo: formData.get('tipo') as TipoTitulo,
      dataVencimento: new Date(formData.get('dataVencimento') as string),
      dataPagamento: isNaN(
        new Date(formData.get('dataPagamento') as string).getTime()
      )
        ? null
        : new Date(formData.get('dataPagamento') as string),
      situacao: formData.get('situacao') as SituacaoTitulo,
    };

    this.dataManager
      .editarTitulo(this.titulo!.id, tituloEditado)
      .then((titulo) => {
        MessagesControl.publishMessage(
          'titulo-editado',
          titulo,
          this.componentID
        );
      });
  }

  private novoTitulo(formData: FormData) {
    let criarTitulo: CriarTituloDto;

    criarTitulo = {
      numero: formData.get('numero') as string,
      valor: +(formData.get('valor') as string).replace(',', '.'),
      descricao: formData.get('descricao') as string,
      tipo: formData.get('tipo') as TipoTitulo,
      dataVencimento: new Date(formData.get('dataVencimento') as string),
      dataPagamento: isNaN(
        new Date(formData.get('dataPagamento') as string).getTime()
      )
        ? null
        : new Date(formData.get('dataPagamento') as string),
      situacao: formData.get('situacao') as SituacaoTitulo,
    };

    this.dataManager.salvarTitulo(criarTitulo).then((titulo) => {
      MessagesControl.publishMessage('titulo-criado', titulo, this.componentID);
    });
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

    if (
      (formData.get('situacao') as string) === 'PAGO' &&
      isNaN(new Date(formData.get('dataPagamento') as string).getTime())
    )
      errors.push(
        `Quando a situação é 'Pago', a data de pagamento precisa ser válida`
      );

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
