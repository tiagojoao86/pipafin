import { Router } from 'express';
import bodyParser from 'body-parser';
import { TituloController } from './api/controller/titulo-controller.js';
import { TituloService } from './api/service/titulo.service.js';
import 'reflect-metadata';
import { TituloRepository } from './api/repository/titulo-repository.js';
import { Database } from './api/repository/database.js';

export class BackendApp {
  private dataBase = new Database();
  private tituloService: TituloService = new TituloService(
    new TituloRepository(this.dataBase)
  );

  constructor(private app: any) {
    this.configureLibs();
    this.configureRoutes();
  }

  private configureLibs(): void {
    this.app.use(bodyParser.json());
  }

  private configureRoutes(): void {
    this.app.use(
      '/api/titulo',
      new TituloController(Router(), this.tituloService).routes()
    );
  }
}
