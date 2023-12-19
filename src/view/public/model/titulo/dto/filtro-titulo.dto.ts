/*export interface FiltroTituloDto {
  filtros?: Array<FiltroDto>;
}

export interface FiltroDto {
  campo?: string;
  operacao?: FiltroOperacaoDto;
  valor: string;
}

export enum FiltroOperacaoDto {
  IGUAL = 'IGUAL',
  DIFERENTE = 'DIFERENTE',
  CONTENDO = 'CONTENDO',
  NAO_CONTENDO = 'NAO_CONTENDO',
  MAIOR = 'MAIOR',
  MENOR = 'MENOR',
  MAIOR_IGUAL = 'MAIOR_IGUAL',
  MENOR_IGUAL = 'MENOR_IGUAL',
}*/

export class FiltroTituloNumeroDto {
  numero?: string;
}
