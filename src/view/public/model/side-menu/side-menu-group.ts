import { SideMenuItem } from './side-menu-item.js';

export interface SideMenuGroup {
  icon: string;
  name: string;
  url: string;
  itens: SideMenuItem[];
}
