import { randomUUID } from 'crypto';
import { CriarTituloDto } from '../../view/public/model/titulo/dto/criar-titulo.dto.js';
import { FiltroTituloNumeroDto } from '../../view/public/model/titulo/dto/filtro-titulo.dto.js';
import {
  criarTituloDtoDoModelo,
  TituloDto,
} from '../../view/public/model/titulo/dto/titulo.dto.js';
import { SituacaoTitulo } from '../../view/public/model/titulo/enum/situacao-titulo.enum.js';
import { Titulo } from '../../view/public/model/titulo/titulo.model.js';
import { EditarTituloDto } from 'src/view/public/model/titulo/dto/editar-titulo.dto.js';
import { TituloRepository } from '../repository/titulo-repository.js';

export class TituloService {
  private titulos = new Array<Titulo>();

  constructor(private repository: TituloRepository) {}

  public async buscarTitulos(): Promise<TituloDto[]> {
    const lista = await this.repository.listarTitulo();

    return lista.map((tit) => criarTituloDtoDoModelo(tit));
  }

  public async criarTitulo(dto: CriarTituloDto): Promise<TituloDto> {
    const titulo = new Titulo(
      dto.numero,
      dto.valor,
      dto.descricao,
      dto.tipo,
      SituacaoTitulo.ABERTO,
      dto.dataVencimento,
      dto.dataPagamento
    );

    const newTitulo = await this.repository.salvarTitulo(titulo);

    return criarTituloDtoDoModelo(newTitulo);
  }

  public async buscarTituloPorId(id: string): Promise<TituloDto | null> {
    const titulo = await this.repository.buscarTituloPeloId(id);

    if (!titulo) return null;

    return criarTituloDtoDoModelo(titulo);
  }

  public async removerTituloPeloId(
    ids: string[]
  ): Promise<number | null | undefined> {
    const deleteResult = await this.repository.deletarTituloPorIds(ids);

    return deleteResult?.affected;
  }

  public async alterarSituacaoTitulo(
    id: string,
    novaSituacao: SituacaoTitulo
  ): Promise<TituloDto | null> {
    const titulo = await this.repository.editarSituacaoTitulo(id, novaSituacao);

    if (titulo) return criarTituloDtoDoModelo(titulo);

    return null;
  }

  public async editarTitulo(
    id: string,
    tituloEditado: EditarTituloDto
  ): Promise<Titulo | null> {
    let titulo = await this.buscarTituloPorId(id);
    if (titulo) {
      if (tituloEditado.numero) titulo.numero = tituloEditado.numero;
      if (tituloEditado.valor) titulo.valor = tituloEditado.valor;
      if (tituloEditado.descricao) titulo.descricao = tituloEditado.descricao;
      if (tituloEditado.tipo) titulo.tipo = tituloEditado.tipo;
      if (tituloEditado.situacao) titulo.situacao = tituloEditado.situacao;
      if (tituloEditado.dataVencimento)
        titulo.dataVencimento = tituloEditado.dataVencimento;
      if (tituloEditado.dataPagamento)
        titulo.dataPagamento = tituloEditado.dataPagamento;

      return await this.repository.editarTitulo(titulo);
    }

    return null;
  }

  public filtrarTitulosPeloNumero(
    filtro: FiltroTituloNumeroDto
  ): Array<TituloDto> {
    return this.titulos
      .filter((tit) => tit.numero === filtro.numero)
      .map((tit) => criarTituloDtoDoModelo(tit));
  }
}
