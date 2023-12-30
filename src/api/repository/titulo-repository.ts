import { Pool } from 'pg';
import { database } from './database';

export class TituloRepository {
  pool: Pool;
  constructor() {
    this.pool = database.getConnection();
  }
}
