import { BaseComponent } from '../base.component.js';

export class ModalComponent extends BaseComponent {
  contentID: string = '';
  overlayEl: HTMLElement = document.createElement('div');
  modal: HTMLElement = document.createElement('div');

  constructor() {
    super();
  }

  public setContentID(contentID: string): void {
    this.contentID = contentID;
  }

  public async openModal(
    width: number,
    height: number,
    url: string
  ): Promise<boolean> {
    const page = await this.buildModal(width, height, url);
    this.modal.innerHTML = page;
    document.body.appendChild(this.overlayEl);

    return new Promise((resolve) => {
      resolve(true);
    });
  }

  async buildModal(
    width: number,
    height: number,
    url: string
  ): Promise<string> {
    this.overlayEl.classList.add('modal-overlay');
    this.overlayEl.addEventListener('click', this.closeModal.bind(this));

    this.modal.style.width = `${width}px`;
    this.modal.style.height = `${height}px`;
    this.modal.classList.add('modal');
    this.modal.addEventListener('click', ($event) => {
      $event.stopPropagation();
    });
    this.overlayEl.appendChild(this.modal);

    const response = await fetch(url);
    return response.text();
  }

  private closeModal(): void {
    super.unsubscribeMessages();
    document.body.removeChild(this.overlayEl);
  }

  protected handleMessages(
    message: string,
    payload: any,
    origin: string
  ): void {
    if (message === 'close-modal' && origin === this.contentID) {
      this.closeModal();
    }
  }
}
