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

  public async openDialog(width: number, height: number, dialog: string) {
    this.buildBaseModal(width, height, false);
    this.modal.innerHTML = dialog;
    document.body.appendChild(this.overlayEl);

    return new Promise((resolve) => {
      resolve(true);
    });
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
    this.buildBaseModal(width, height, true);

    const response = await fetch(url);
    return response.text();
  }

  private buildBaseModal(
    width: number,
    height: number,
    closeOnOverlayClick: boolean
  ) {
    this.overlayEl.classList.add('modal-overlay');

    if (closeOnOverlayClick)
      this.overlayEl.addEventListener('click', this.closeModal.bind(this));

    this.modal.style.width = width ? `${width}px` : 'fit-content';
    this.modal.style.height = height ? `${height}px` : 'fit-content';
    this.modal.classList.add('modal');
    this.modal.addEventListener('click', ($event) => {
      $event.stopPropagation();
    });
    this.overlayEl.appendChild(this.modal);
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
