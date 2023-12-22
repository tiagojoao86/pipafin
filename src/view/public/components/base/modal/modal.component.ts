import { resolve } from 'path';

export class ModalComponent {
  overlayEl: HTMLElement = document.createElement('div');
  modal: HTMLElement = document.createElement('div');

  constructor() {}

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

  public closeModal($event: Event): void {
    document.body.removeChild(this.overlayEl);
  }
}
