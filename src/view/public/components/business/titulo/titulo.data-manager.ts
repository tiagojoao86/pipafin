import { Titulo } from 'src/view/public/model/titulo/titulo.model.js';
import { BaseDataManger } from '../../base/base.data-manager.js';

export class TituloDataManager extends BaseDataManger {
  url = this.baseUrl + 'titulo';

  constructor() {
    super();
  }

  public async getTitulo(): Promise<Titulo[]> {
    const list = await this.getJson(this.url).then((data) => data);

    return list;
  }
}
