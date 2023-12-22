import { MessagesControl } from './messages.component.js';

export abstract class BaseComponent {
  componentID: string = this.generateUUID();

  constructor() {
    MessagesControl.subscribe(this);

    addEventListener('beforeunload', this.unsubscribeMessages.bind(this));
  }

  protected unsubscribeMessages() {
    MessagesControl.unsubscribe(this);
  }

  public listenMessages(message: string, payload: any, origin: string) {
    this.handleMessages(message, payload, origin);
  }

  protected handleMessages(message: string, payload: any, origin: string) {}

  private generateUUID() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) => {
      var r = (Math.random() * 16) | 0,
        v = c === 'x' ? r : (r & 0x3) | 0x8;
      return v.toString(16);
    });
  }
}
