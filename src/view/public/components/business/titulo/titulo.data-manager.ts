import { Titulo } from 'src/view/public/model/titulo/titulo.model.js';
import { BaseDataManger } from '../../base/base.data-manager.js';
import { CriarTituloDto } from 'src/view/public/model/titulo/dto/criar-titulo.dto.js';
import { EditarTituloDto } from 'src/view/public/model/titulo/dto/editar-titulo.dto.js';

export class TituloDataManager extends BaseDataManger {
  url = this.baseUrl + 'titulo';

  constructor() {
    super();
  }

  public async listarTitulo(): Promise<Titulo[]> {
    const options = {
      method: this.METHODS.GET,
    };
    const list = await this.getJson(this.url, options).then((data) => data);

    return list;
  }

  public async salvarTitulo(titulo: CriarTituloDto): Promise<Titulo> {
    const options = {
      method: this.METHODS.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(titulo),
    };

    const tituloSalvo = await this.getJson(this.url, options).then(
      (data) => data
    );

    return tituloSalvo;
  }

  public async removerTitulo(
    ids: string[]
  ): Promise<number | null | undefined> {
    const options = {
      method: this.METHODS.DELETE,
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ ids: ids }),
    };

    console.log(options);

    const registrosRemovidos = await this.getJson(this.url, options).then(
      (data) => data
    );

    return registrosRemovidos;
  }

  public async editarTitulo(
    id: string,
    titulo: EditarTituloDto
  ): Promise<Titulo> {
    console.log(titulo);
    console.log(JSON.stringify(titulo));
    const options = {
      method: this.METHODS.PATCH,
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(titulo),
    };

    const tituloSalvo = await this.getJson(this.url + `/${id}`, options).then(
      (data) => data
    );

    return tituloSalvo;
  }
}
