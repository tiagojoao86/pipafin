import { Router } from 'express';
import { FiltroTituloNumeroDto } from '../../view/public/model/titulo/dto/filtro-titulo.dto';
import { SituacaoTitulo } from '../../view/public/model/titulo/enum/situacao-titulo.enum';
import { TituloService } from '../service/titulo.service';
import { EditarTituloDto } from 'src/view/public/model/titulo/dto/editar-titulo.dto';

export class TituloController {
  constructor(private router: Router, private tituloService: TituloService) {}

  public routes(): Router {
    this.router.get('/', (req, res, next) => {
      res.status(200).json(this.tituloService.buscarTitulos());
    });

    this.router.post('/', (req, res, next) => {
      res.status(200).json(this.tituloService.criarTitulo(req.body));
    });

    this.router.get('/:id', (req, res, next) => {
      res.status(200).json(this.tituloService.buscarTituloPorId(req.params.id));
    });

    this.router.delete('/:id', (req, res, next) => {
      res
        .status(200)
        .json(this.tituloService.removerTituloPeloId(req.params.id));
    });

    this.router.patch('/:id', (req, res, next) => {
      const tituloEditado: EditarTituloDto = req.body;
      res
        .status(200)
        .json(this.tituloService.editarTitulo(req.params.id, tituloEditado));
    });

    this.router.patch('/:id/situacao', (req, res, next) => {
      const novaSituacao: SituacaoTitulo = req.body.situacao;
      res
        .status(200)
        .json(
          this.tituloService.alterarSituacaoTitulo(req.params.id, novaSituacao)
        );
    });

    this.router.post('/filtrar', (req, res, next) => {
      const filtroDto: FiltroTituloNumeroDto = req.body;
      res
        .status(200)
        .json(this.tituloService.filtrarTitulosPeloNumero(filtroDto));
    });

    return this.router;
  }
}
