import { Request, Router } from 'express';
import { FiltroTituloNumeroDto } from '../../view/public/model/titulo/dto/filtro-titulo.dto';
import { SituacaoTitulo } from '../../view/public/model/titulo/enum/situacao-titulo.enum';
import { TituloService } from '../service/titulo.service';
import { EditarTituloDto } from 'src/view/public/model/titulo/dto/editar-titulo.dto';

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

    this.router.patch('/:id/situacao', (req, res, next) => {
      const novaSituacao: SituacaoTitulo = req.body.situacao;
      this.tituloService
        .alterarSituacaoTitulo(req.params.id, novaSituacao)
        .then((situacaoAtualizada) => res.status(200).json(situacaoAtualizada));
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
