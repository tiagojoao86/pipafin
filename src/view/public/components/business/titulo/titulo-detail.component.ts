import { CriarTituloDto } from 'src/view/public/model/titulo/dto/criar-titulo.dto';
import { TituloDataManager } from './titulo.data-manager';
import { TipoTitulo } from 'src/view/public/model/titulo/enum/tipo-titulo.enum';

export class TituloDetail {
  salvarButton: HTMLElement = document.getElementById('btnSalvarTitulo')!;
  tituloDetail: HTMLFormElement = document.querySelector('form')!;
  inputValorTitulo: HTMLInputElement = document.getElementById(
    'inputValorTitulo'
  )! as HTMLInputElement;

  constructor(private dataManager: TituloDataManager) {
    this.addEventListeners();
  }

  addEventListeners() {
    this.salvarButton?.addEventListener('click', this.salvarTitulo.bind(this));
    this.inputValorTitulo.addEventListener(
      'keyup',
      this.formatMoney.bind(this)
    );
  }

  formatMoney($event: any) {
    console.log($event);
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
        console.log('value', value);
        const decimal = value.substring(value.length - 2, value.length);
        console.log('decimal', decimal);
        let inteiro = value.substring(0, value.length - 2);
        console.log('inteiro', inteiro);
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

    this.dataManager.salvarTitulo(criarTitulo);
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

    console.log(errors);

    return errors.length === 0;
  }
}
