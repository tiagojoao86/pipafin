import { IsNotEmpty } from 'node_modules/class-validator/types/index';
import { TipoTitulo } from '../enum/tipo-titulo.enum';
import { SituacaoTitulo } from '../enum/situacao-titulo.enum';

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

  dataPagamento: Date | null;

  situacao: SituacaoTitulo;

  constructor(
    numero: string,
    valor: number,
    descricao: string,
    tipo: TipoTitulo,
    situacao: SituacaoTitulo,
    dataVencimento: Date,
    dataPagamento: Date | null
  ) {
    this.numero = numero;
    this.valor = valor;
    this.descricao = descricao;
    this.tipo = tipo;
    this.situacao = situacao;
    this.dataVencimento = dataVencimento;
    this.dataPagamento = dataPagamento;
  }
}
