import { Request, Router } from 'express';
import { TituloService } from '../service/titulo.service';
import { EditarTituloDto } from 'src/view/public/model/titulo/dto/editar-titulo.dto';
import { TituloPagarDto } from 'src/view/public/model/titulo/dto/titulo-pagar.dto';
import { FiltrarTituloDTO } from 'src/view/public/model/titulo/dto/filtrar-titulo';

export class TituloController {
  constructor(private router: Router, private tituloService: TituloService) {}

  public routes(): Router {
    this.router.get('/', (req, res, next) => {
      this.tituloService
        .buscarTitulos()
        .then((titulos) => res.status(200).json(titulos));
    });

    this.router.post('/', (req, res, next) => {
      this.tituloService
        .criarTitulo(req.body)
        .then((newTitulo) => res.status(200).json(newTitulo));
    });

    this.router.get('/:id', (req, res, next) => {
      this.tituloService
        .buscarTituloPorId(req.params.id)
        .then((titulo) => res.status(200).json(titulo));
    });

    this.router.delete('/', (req: Request<string[]>, res, next) => {
      this.tituloService
        .removerTituloPeloId(req.body.ids)
        .then((titulosRemovidos) => res.status(200).json(titulosRemovidos));
    });

    this.router.patch('/:id', (req, res, next) => {
      const tituloEditado: EditarTituloDto = req.body;
      this.tituloService
        .editarTitulo(req.params.id, tituloEditado)
        .then((tituloEditado) => res.status(200).json(tituloEditado));
    });

    this.router.patch(
      '/editar-titulo/registrar-pago',
      (req: Request<TituloPagarDto>, res, next) => {
        this.tituloService
          .registrarPagamento(req.body)
          .then((registros) => res.status(200).json(registros));
      }
    );

    this.router.post('/filtrar', (req, res, next) => {
      const filtroDto: FiltrarTituloDTO = req.body;
      this.tituloService
        .filtrar(filtroDto)
        .then((filtrarResult) => res.status(200).json(filtrarResult));
    });

    return this.router;
  }
}
