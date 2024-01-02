import { PrimaryGeneratedColumn } from 'typeorm';

export abstract class BaseModel {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  constructor() {}
}
