import { DialogSeverity } from './dialog-severity.js';
import { DialogType } from './dialog-type.js';

export interface DialogOptions {
  severity: DialogSeverity;
  type: DialogType;
  YesOkCb?: Function;
  NoCb?: Function;
}
