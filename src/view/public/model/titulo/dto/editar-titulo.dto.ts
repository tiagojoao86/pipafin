import { SituacaoTitulo } from '../enum/situacao-titulo.enum';
import { TipoTitulo } from '../enum/tipo-titulo.enum';

export interface EditarTituloDto {
  numero?: string;
  valor?: number;
  descricao?: string;
  tipo?: TipoTitulo;
  situacao?: SituacaoTitulo;
  dataVencimento?: Date;
  dataPagamento?: Date;
}
