import { BaseComponent } from '../base.component.js';
import { MessagesControl } from '../messages.component.js';
import { DialogOptions } from './dialog-options.js';
import { DialogSeverity } from './dialog-severity.js';
import { DialogType } from './dialog-type.js';
import { ModalComponent } from './modal.component.js';

export class DialogComponent extends BaseComponent {
  modal: ModalComponent;
  constructor() {
    super();
    this.modal = new ModalComponent();
  }

  public openDialog(title: string, message: string, options: DialogOptions) {
    this.modal
      .openDialog(
        600,
        0,
        this.dialogHtml(title, message, options.severity, options.type)
      )
      .then(() => {
        this.modal.setContentID(this.componentID);
        this.addEventListeners(options);
      });
  }

  private dialogHtml(
    title: string,
    message: string,
    severity: DialogSeverity,
    type: DialogType
  ): string {
    return `
      <div class="dialog-title">${title}</div>
      <hr/>
      <div class="flex-row-container flex-center">
        <div class="${this.getBackgroundIcon(
          severity
        )}"><div class="icon icon-24 ${this.getIcon(severity)}"></div></div>
        <div class="dialog-message">${message}</div>
      </div>
      <div class="flex-row-container-reverse">
        ${this.getButtons(type)}
      </div>
    `;
  }

  private getBackgroundIcon(type: DialogSeverity): string {
    if (type === DialogSeverity.INFO)
      return 'icon-background icon-info-background';
    else if (type === DialogSeverity.WARNING)
      return 'icon-background icon-warning-background';
    else if (type === DialogSeverity.ERROR)
      return 'icon-background icon-error-background';

    return 'icon-background icon-info-background';
  }

  private getIcon(type: DialogSeverity): string {
    if (type === DialogSeverity.INFO) return 'icon-info icon-color-white';
    else if (type === DialogSeverity.WARNING)
      return 'icon-warning icon-color-black';
    else if (type === DialogSeverity.ERROR)
      return 'icon-error icon-color-white';

    return 'icon-info icon-color-text';
  }

  private getButtons(type: DialogType): string {
    if (type === DialogType.OK)
      return `<button type="button" class="btn btn-primary btn-round btn-font-white" id="dialog__btn-ok">Ok</button>`;
    else if (type === DialogType.YES_NO)
      return `
    <button type="button" class="btn btn-success btn-round btn-font-white" id="dialog__btn-ok">Sim</button>
    <button type="button" class="btn btn-danger btn-round btn-font-white" id="dialog__btn-no">Não</button>
    `;
    else return '';
  }

  private addEventListeners(options: DialogOptions) {
    if (options.type === DialogType.OK || options.type === DialogType.YES_NO) {
      const btn = document.getElementById('dialog__btn-ok')!;
      btn.addEventListener('click', this.createYesOkCb(options).bind(this));
    }

    if (options.type === DialogType.YES_NO) {
      const btnNo = document.getElementById('dialog__btn-no')!;
      btnNo.addEventListener('click', this.createNoCb(options).bind(this));
    }
  }

  private createYesOkCb(options: DialogOptions): Function {
    return function (this: any) {
      if (options.YesOkCb) options.YesOkCb();

      this.publishCloseModal();
    };
  }

  private createNoCb(options: DialogOptions): Function {
    return function (this: any) {
      if (options.NoCb) options.NoCb();

      this.publishCloseModal();
    };
  }

  publishCloseModal() {
    super.unsubscribeMessages();
    MessagesControl.publishMessage('close-modal', null, this.componentID);
  }
}
