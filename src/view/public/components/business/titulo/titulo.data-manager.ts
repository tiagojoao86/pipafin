import { Titulo } from 'src/view/public/model/titulo/titulo.model.js';
import { BaseDataManger } from '../../base/base.data-manager.js';
import { CriarTituloDto } from 'src/view/public/model/titulo/dto/criar-titulo.dto.js';
import { EditarTituloDto } from 'src/view/public/model/titulo/dto/editar-titulo.dto.js';

export class TituloDataManager extends BaseDataManger {
  url = this.baseUrl + 'titulo';

  constructor() {
    super();
  }

  public async getTitulo(): Promise<Titulo[]> {
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

  public async removerTitulo(id: string): Promise<Titulo> {
    const options = {
      method: this.METHODS.DELETE,
      headers: {
        'Content-Type': 'application/json',
      },
    };

    const tituloRemovido = await this.getJson(
      this.url + `/${id}`,
      options
    ).then((data) => data);

    return tituloRemovido;
  }

  public async editarTitulo(
    id: string,
    titulo: EditarTituloDto
  ): Promise<Titulo> {
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
