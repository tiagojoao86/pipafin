import { Titulo } from '../../view/public/model/titulo/titulo.model.js';
import { SituacaoTitulo } from '../../view/public/model/titulo/enum/situacao-titulo.enum.js';
import { Database } from './database.js';
import { Repository, DeleteResult, UpdateResult } from 'typeorm';

export class TituloRepository {
  repository: Repository<Titulo>;

  constructor(private dataBase: Database) {
    this.repository = this.dataBase.getConnection().getRepository(Titulo);
  }

  public async salvarTitulo(titulo: Titulo): Promise<Titulo> {
    return await this.repository.save(titulo);
  }

  public async listarTitulo(): Promise<Titulo[]> {
    return await this.repository.find();
  }

  public async buscarTituloPeloId(id: string): Promise<Titulo | null> {
    return await this.repository.findOneBy({ id: id });
  }

  public async deletarTituloPorIds(
    ids: string[]
  ): Promise<DeleteResult | null> {
    return await this.repository
      .createQueryBuilder()
      .delete()
      .from(Titulo)
      .where('id in (:...ids)', { ids: ids })
      .execute();
  }

  public async editarTitulo(titulo: Titulo): Promise<Titulo | null> {
    return await this.repository.save(titulo);
  }

  public async registrarPagamento(
    ids: string[],
    datapagamento: Date
  ): Promise<UpdateResult> {
    return await this.repository
      .createQueryBuilder()
      .update(Titulo)
      .set({ situacao: SituacaoTitulo.PAGO, dataPagamento: datapagamento })
      .where('id in (:...ids)', { ids: ids })
      .returning('id')
      .execute();
  }

  public async editarSituacaoTitulo(
    id: string,
    novaSituacao: SituacaoTitulo
  ): Promise<Titulo | null> {
    const updateResult = await this.repository
      .createQueryBuilder()
      .update(Titulo)
      .set({ situacao: novaSituacao })
      .where('id = :id', { id: id })
      .execute();

    if (updateResult && updateResult.affected && updateResult.affected > 0) {
      return await this.buscarTituloPeloId(id);
    }

    return null;
  }
}
