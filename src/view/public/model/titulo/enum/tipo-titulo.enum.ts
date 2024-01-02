export enum TipoTitulo {
  PAGAR = 'PAGAR',
  RECEBER = 'RECEBER',
}

export function getLabelTipoTitulo(tipo: TipoTitulo): string {
  switch (tipo) {
    case TipoTitulo.PAGAR:
      return 'A Pagar';
    case TipoTitulo.RECEBER:
      return 'A Receber';
    default:
      return '';
  }
}
