import { SituacaoTitulo } from '../enum/situacao-titulo.enum.js';
import { TipoTitulo } from '../enum/tipo-titulo.enum.js';
import { Titulo } from '../titulo.model.js';

export interface TituloDto {
  id: string;
  numero: string;
  valor: number;
  descricao: string;
  tipo: TipoTitulo;
  situacao: SituacaoTitulo;
  dataCriacao: Date;
  dataVencimento: Date;
  dataPagamento?: Date;
}

export function criarTituloDtoDoModelo(titulo: Titulo): TituloDto {
  return {
    id: titulo.id,
    numero: titulo.numero,
    valor: titulo.valor,
    descricao: titulo.descricao,
    tipo: titulo.tipo,
    situacao: titulo.situacao,
    dataCriacao: titulo.dataCriacao,
    dataVencimento: titulo.dataVencimento,
    dataPagamento: titulo.dataPagamento,
  };
}
