import { WidthColumnClass } from './width-column-class.enum';

export interface ColumnType {
  header: string;
  dataAttribute: string;
  widthClass: WidthColumnClass;
  hidden?: boolean;
  isId?: boolean;
  formatter?: Function;
}
