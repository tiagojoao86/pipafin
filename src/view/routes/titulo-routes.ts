import { Router } from 'express';

export class TitulosRoutes {
  constructor(private router: Router) {}

  public routes(): Router {
    this.router.get('/', (req, res, next) => {
      res.render('titulo/titulo', {
        pageTitle: 'Manutenção de Títulos',
      });
    });

    this.router.get('/titulo-detail', (req, res, next) => {
      res.render('titulo/titulo-detail', {
        pageTitle: 'Título',
      });
    });

    return this.router;
  }
}
