export class ModalComponent {
  overlayEl: HTMLElement = document.createElement('div');
  modal: HTMLElement = document.createElement('div');

  constructor(width: number, height: number, url: string) {
    this.overlayEl.classList.add('modal-overlay');
    this.overlayEl.addEventListener('click', this.closeModal.bind(this));

    this.modal.style.width = `${width}px`;
    this.modal.style.height = `${height}px`;
    this.modal.classList.add('modal');
    this.modal.addEventListener('click', ($event) => {
      $event.stopPropagation();
    });
    this.overlayEl.appendChild(this.modal);

    fetch('titulos/new').then((response) => {
      response.text().then((page) => {
        this.modal.innerHTML = page;
      });
    });
  }

  public openModal(): void {
    document.body.appendChild(this.overlayEl);
  }

  public closeModal($event: Event): void {
    document.body.removeChild(this.overlayEl);
  }
}
