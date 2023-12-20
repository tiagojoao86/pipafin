import path, { dirname } from 'path';
import { TitulosRoutes } from './view/routes/titulos-routes.js';
import express, { Router } from 'express';
import { fileURLToPath } from 'url';

export class FrontendApp {
  __dirname = dirname(fileURLToPath(import.meta.url));

  constructor(private app: any) {
    this.configureLibs();
    this.configureRoutes();
  }

  private configureLibs(): void {
    this.app.set('view engine', 'ejs');
    this.app.set('views', path.join(this.__dirname, 'view', 'views'));
    this.app.use(express.static(path.join(this.__dirname, 'view', 'public')));
  }

  private configureRoutes(): void {
    this.app.use('/financeiro', new TitulosRoutes(Router()).routes());

    this.app.use('/inicio', (req: any, res: any) => {
      res.render('inicio', {
        pageTitle: 'Pipafin',
      });
    });

    this.app.use('/login', (req: any, res: any) => {
      res.render('login', {
        pageTitle: 'Pipafin',
      });
    });

    this.app.use((req: any, res: any, next: any) => {
      if (req.originalUrl === '/' || req.originalUrl === '') {
        res.redirect('/login');
        return;
      }
      res.status(404).render('404', {
        pageTitle: '',
      });
    });
  }
}
