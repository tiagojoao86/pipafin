import { Router } from 'express';

export class TitulosRoutes {
  constructor(private router: Router) {}

  public routes(): Router {
    this.router.get('/titulos', (req, res, next) => {
      res.render('titulo/titulo', {
        pageTitle: 'Manutenção de Títulos',
      });
    });

    this.router.get('/titulos/new', (req, res, next) => {
      res.render('titulo/criar-titulo', {
        pageTitle: 'Título',
      });
    });

    return this.router;
  }
}
