import { BaseComponent } from '../base.component.js';

export class ModalComponent {
  overlayEl: HTMLElement = document.createElement('div');
  modal: HTMLElement = document.createElement('div');

  constructor() {}

  public async openDialog(width: number, height: number, dialog: string) {
    this.buildBaseModal(width, height, false);
    this.modal.innerHTML = dialog;
    document.body.appendChild(this.overlayEl);

    return new Promise((resolve) => {
      resolve(true);
    });
  }

  public async openModal(
    width: number | null,
    height: number | null,
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
    width: number | null,
    height: number | null,
    url: string
  ): Promise<string> {
    this.buildBaseModal(width, height, true);

    const response = await fetch(url);
    return response.text();
  }

  private buildBaseModal(
    width: number | null,
    height: number | null,
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

  public closeModal(): void {
    document.body.removeChild(this.overlayEl);
  }
}
