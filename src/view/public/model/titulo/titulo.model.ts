import { SituacaoTitulo } from "./enum/situacao-titulo.enum";
import { TipoTitulo } from "./enum/tipo-titulo.enum";


export class Titulo {
  id: string;
  numero: string;
  valor: number;
  descricao: string;
  tipo: TipoTitulo;
  situacao: SituacaoTitulo;
  dataCriacao: Date;
  dataVencimento: Date;
  dataPagamento: Date;

  constructor(id: string, numero: string, valor: number, descricao: string,
    tipo: TipoTitulo, situacao: SituacaoTitulo, dataVencimento: Date,
    dataPagamento: Date) { 
    this.id = id;
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
