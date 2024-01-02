import { BaseModel } from '../base-model.js';
import { SituacaoTitulo } from './enum/situacao-titulo.enum.js';
import { TipoTitulo } from './enum/tipo-titulo.enum.js';
import { Entity, Column } from 'typeorm';

@Entity({ name: 'titulo' })
export class Titulo extends BaseModel {
  @Column({ name: 'numero' })
  numero: string;

  @Column({ name: 'valor', type: 'numeric' })
  valor: number;

  @Column({ name: 'descricao' })
  descricao: string;

  @Column({ name: 'tipo', type: 'enum', enum: TipoTitulo })
  tipo: TipoTitulo;

  @Column({ name: 'situacao', type: 'enum', enum: SituacaoTitulo })
  situacao: SituacaoTitulo;

  @Column({ name: 'data_criacao', type: 'timestamp without time zone' })
  dataCriacao: Date;

  @Column({ name: 'data_vencimento', type: 'date' })
  dataVencimento: Date;

  @Column({ name: 'data_pagamento', type: 'date' })
  dataPagamento?: Date;

  constructor(
    numero: string,
    valor: number,
    descricao: string,
    tipo: TipoTitulo,
    situacao: SituacaoTitulo,
    dataVencimento: Date,
    dataPagamento?: Date,
    id?: string
  ) {
    super();
    if (id) this.id = id;
    this.numero = numero;
    this.valor = valor;
    this.descricao = descricao;
    this.tipo = tipo;
    this.situacao = situacao;
    this.dataCriacao = new Date();
    this.dataVencimento = dataVencimento;
    if (dataPagamento) this.dataPagamento = dataPagamento;
  }
}
