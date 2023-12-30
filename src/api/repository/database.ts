import { Pool } from 'pg';

class Database {
  pool: Pool;
  random: number;

  constructor() {
    this.pool = new Pool({
      host: 'localhost',
      user: 'pipa',
      password: 'pipa123',
      database: 'pipafin',
    });
    this.random = Math.round(Math.random() * 10);
  }

  public getConnection(): Pool {
    console.log(this.random);
    return this.pool;
  }
}

export const database = new Database();
