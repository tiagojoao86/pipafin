import { Router } from 'express';
import bodyParser from 'body-parser';
import { TituloController } from './api/controller/titulo-controller.js';
import { TituloService } from './api/service/titulo.service.js';

export class BackendApp {
  private tituloService: TituloService = new TituloService();

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
