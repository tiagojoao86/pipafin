import { randomUUID } from 'crypto';
import { CriarTituloDto } from '../../view/public/model/titulo/dto/criar-titulo.dto.js';
import { FiltroTituloNumeroDto } from '../../view/public/model/titulo/dto/filtro-titulo.dto.js';
import { TituloRemovidoDto } from '../../view/public/model/titulo/dto/titulo-removido.dto.js';
import {
  criarTituloDtoDoModelo,
  TituloDto,
} from '../../view/public/model/titulo/dto/titulo.dto.js';
import { SituacaoTitulo } from '../../view/public/model/titulo/enum/situacao-titulo.enum.js';
import { Titulo } from '../../view/public/model/titulo/titulo.model.js';

export class TituloService {
  private titulos = new Array<Titulo>();

  constructor() {}

  public buscarTitulos(): Array<TituloDto> {
    return this.titulos.map((tit) => criarTituloDtoDoModelo(tit));
  }

  public criarTitulo(dto: CriarTituloDto): TituloDto | null {
    const titulo = {
      id: randomUUID(),
      numero: dto.numero,
      valor: dto.valor,
      descricao: dto.descricao,
      tipo: dto.tipo,
      situacao: SituacaoTitulo.ABERTO,
      dataCriacao: new Date(),
      dataVencimento: dto.dataVencimento,
      dataPagamento: dto.dataPagamento,
    };

    this.adicionarTitulo(titulo);

    return criarTituloDtoDoModelo(titulo);
  }

  public buscarTituloPorId(id: string): TituloDto | null {
    const titulo = this.titulos.find((tit) => tit.id === id);

    if (!titulo) return null;

    return criarTituloDtoDoModelo(titulo);
  }

  public removerTituloPeloId(id: string): TituloRemovidoDto | null {
    const index = this.titulos.findIndex((tit) => tit.id === id);

    if (index !== -1) {
      const { numero, valor, descricao } = this.titulos.splice(index, 1)[0];

      return { numero, valor, descricao };
    }

    return null;
  }

  public alterarSituacaoTitulo(id: string, novaSituacao: SituacaoTitulo) {
    const titulo = this.titulos.find((tit) => tit.id === id);

    if (!titulo) return null;

    titulo.situacao = novaSituacao;

    return criarTituloDtoDoModelo(titulo);
  }

  public filtrarTitulosPeloNumero(
    filtro: FiltroTituloNumeroDto
  ): Array<TituloDto> {
    return this.titulos.filter((tit) => tit.numero === filtro.numero);
  }

  private adicionarTitulo(titulo: Titulo) {
    this.titulos.push(titulo);
  }
}
