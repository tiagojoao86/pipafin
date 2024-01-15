import { CriarTituloDto } from '../../view/public/model/titulo/dto/criar-titulo.dto.js';
import {
  criarTituloDtoDoModelo,
  TituloDto,
} from '../../view/public/model/titulo/dto/titulo.dto.js';
import { Titulo } from '../../view/public/model/titulo/titulo.model.js';
import { EditarTituloDto } from 'src/view/public/model/titulo/dto/editar-titulo.dto.js';
import { TituloRepository } from '../repository/titulo-repository.js';
import { TituloPagarDto } from '../../view/public/model/titulo/dto/titulo-pagar.dto.js';
import { FiltrarTituloDTO } from '../../view/public/model/titulo/dto/filtrar-titulo.js';
import { FilterResult } from '../../view/public/model/pagination/filter-result.js';

export class TituloService {
  private titulos = new Array<Titulo>();

  constructor(private repository: TituloRepository) {}

  public async buscarTitulos(): Promise<TituloDto[]> {
    const lista = await this.repository.listarTitulo();

    return lista.map((tit) => criarTituloDtoDoModelo(tit));
  }

  public async filtrar(
    filtro: FiltrarTituloDTO
  ): Promise<FilterResult<TituloDto>> {
    const result = await this.repository.filtrar(filtro);

    const totalFiltro = await this.repository.countFiltrar(filtro);

    filtro.totalPages = Math.ceil(totalFiltro / filtro.pageSize);

    const lista = result.map((tit) => criarTituloDtoDoModelo(tit));

    return new FilterResult(lista, filtro);
  }

  public async criarTitulo(dto: CriarTituloDto): Promise<TituloDto> {
    const titulo = new Titulo(
      dto.numero,
      dto.valor,
      dto.descricao,
      dto.tipo,
      dto.situacao,
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

  public async registrarPagamento(
    dto: TituloPagarDto
  ): Promise<TituloPagarDto | null> {
    const updateResult = await this.repository.registrarPagamento(
      dto.ids,
      dto.dataPagamento
    );

    if (updateResult && updateResult.raw)
      return {
        ids: (updateResult.raw as Titulo[]).map((it) => it.id),
        dataPagamento: dto.dataPagamento,
      };
    else return null;
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

      titulo.dataPagamento = tituloEditado.dataPagamento;

      return await this.repository.editarTitulo(titulo);
    }

    return null;
  }
}
