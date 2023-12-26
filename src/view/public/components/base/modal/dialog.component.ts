import { BaseComponent } from '../base.component.js';
import { DialogType } from './dialog-type.js';
import { ModalComponent } from './modal.component.js';

export class DialogComponent extends BaseComponent {
  modal: ModalComponent;
  constructor() {
    super();
    this.modal = new ModalComponent();
  }

  public openDialog(title: string, message: string, type: DialogType) {
    this.modal
      .openDialog(600, 0, this.dialogHtml(title, message, type))
      .then((resolve) => {
        console.log(resolve);
      });
  }

  private dialogHtml(title: string, message: string, type: DialogType): string {
    return `
      <div class="dialog-title">${title}</div>
      <div class="flex-row-container flex-center">
        <div class="${this.getBackgroundIcon(
          type
        )}"><div class="icon icon-36 ${this.getIcon(type)}"></div></div>
        <div class="dialog-message">${message}</div>
      </div>
      <div class="flex-row-container-reverse">
        ${this.getButtons(type)}
      </div>
    `;
  }

  private getBackgroundIcon(type: DialogType): string {
    if (type === DialogType.INFO) return 'icon-background icon-info-background';
    else if (type === DialogType.WARNING)
      return 'icon-background icon-warning-background';
    else if (type === DialogType.ERROR)
      return 'icon-background icon-error-background';

    return 'icon-background icon-info-background';
  }

  private getIcon(type: DialogType): string {
    if (type === DialogType.INFO) return 'icon-info icon-color-white';
    else if (type === DialogType.WARNING)
      return 'icon-warning icon-color-black';
    else if (type === DialogType.ERROR) return 'icon-error icon-color-white';

    return 'icon-info icon-color-text';
  }

  private getButtons(type: DialogType): string {
    if (type === DialogType.INFO || type === DialogType.WARNING) return '';
    else if (type === DialogType.YES_NO) return '';
    else return '';
  }
}
