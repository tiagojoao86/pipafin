import express, { Router } from 'express';
import { BackendApp } from './backend.app.js';
import { FrontendApp } from './frontend.app.js';

export class App {
  app;
  port;
  backend;
  frontend;

  constructor() {
    this.app = express();
    this.port = 3000;
    this.backend = new BackendApp(this.app);
    this.frontend = new FrontendApp(this.app);
  }

  public startApp(): void {
    this.app.listen(this.port);
    console.log(`Server is running on port: ${this.port}`);
  }
}
