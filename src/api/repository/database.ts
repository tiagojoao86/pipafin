import { Titulo } from '../../view/public/model/titulo/titulo.model.js';
import { BaseModel } from '../../view/public/model/base-model.js';
import { DataSource } from 'typeorm';
export class Database {
  datasource: DataSource;
  random: number;

  constructor() {
    this.datasource = new DataSource({
      type: 'postgres',
      host: 'localhost',
      port: 5432,
      database: 'pipafin',
      username: 'pipa',
      password: 'pipa123',
      synchronize: false,
      logging: true,
      entities: [BaseModel, Titulo],
    });

    this.datasource
      .initialize()
      .then(() => {})
      .catch((error: any) => console.log(error));

    this.random = Math.round(Math.random() * 10);
  }

  public getConnection(): DataSource {
    console.log(this.random);
    return this.datasource;
  }
}
