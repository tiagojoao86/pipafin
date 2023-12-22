import { BaseComponent } from './base.component.js';

export class MessagesControl {
  private static subscribers: BaseComponent[] = [];

  static subscribe(member: BaseComponent): void {
    if (this.subscribers.find((it) => it.componentID === member.componentID))
      return;

    this.subscribers.push(member);
  }

  static unsubscribe(member: BaseComponent): void {
    if (this.subscribers.find((it) => it.componentID === member.componentID)) {
      const index = this.subscribers.findIndex(
        (it) => it.componentID === member.componentID
      );

      if (index !== -1) this.subscribers.splice(index, 1);
    }
  }

  static publishMessage(
    message: string,
    payload: any,
    origin: string,
    destination: string = '*'
  ): void {
    if (destination === '*') {
      this.publishAll(message, payload, origin);
      return;
    }

    const target = this.subscribers.find(
      (it) => it.componentID === destination
    );
    if (target) {
      target.listenMessages(message, payload, origin);
    }
  }

  private static publishAll(
    message: string,
    payload: any,
    origin: string
  ): void {
    this.subscribers.forEach((sub) => {
      sub.listenMessages(message, payload, origin);
    });
  }
}
