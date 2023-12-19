import { IsNotEmpty } from 'node_modules/class-validator/types/index';
import { TipoTitulo } from '../enum/tipo-titulo.enum';

export class CriarTituloDto {
  @IsNotEmpty()
  numero: string;

  @IsNotEmpty()
  valor: number;

  @IsNotEmpty()
  descricao: string;

  @IsNotEmpty()
  tipo: TipoTitulo;

  @IsNotEmpty()
  dataVencimento: Date;

  @IsNotEmpty()
  dataPagamento: Date;

  constructor(
    numero: string,
    valor: number,
    descricao: string,
    tipo: TipoTitulo,
    dataVencimento: Date,
    dataPagamento: Date
  ) {
    this.numero = numero;
    this.valor = valor;
    this.descricao = descricao;
    this.tipo = tipo;
    this.dataVencimento = dataVencimento;
    this.dataPagamento = dataPagamento;
  }
}
