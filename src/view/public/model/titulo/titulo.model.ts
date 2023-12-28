import { BaseModel } from '../base-model.js';
import { SituacaoTitulo } from './enum/situacao-titulo.enum.js';
import { TipoTitulo } from './enum/tipo-titulo.enum.js';

export class Titulo extends BaseModel {
  numero: string;
  valor: number;
  descricao: string;
  tipo: TipoTitulo;
  situacao: SituacaoTitulo;
  dataCriacao: Date;
  dataVencimento: Date;
  dataPagamento?: Date;

  constructor(
    id: string,
    numero: string,
    valor: number,
    descricao: string,
    tipo: TipoTitulo,
    situacao: SituacaoTitulo,
    dataVencimento: Date,
    dataPagamento: Date
  ) {
    super(id);
    this.numero = numero;
    this.valor = valor;
    this.descricao = descricao;
    this.tipo = tipo;
    this.situacao = situacao;
    this.dataCriacao = new Date();
    this.dataVencimento = dataVencimento;
    this.dataPagamento = dataPagamento;
  }
}
