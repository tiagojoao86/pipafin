import { SideMenuGroup } from 'src/view/public/model/side-menu/side-menu-group.js';
import { SideMenuItem } from 'src/view/public/model/side-menu/side-menu-item';

export class MainComponent {
  menu: SideMenuGroup[] = [];
  sideMenu: HTMLElement = document.getElementById('side-menu')!;
  sideMenuIcon: HTMLElement = document.getElementById('sideMenuIcon')!;

  constructor() {
    this.populateMenu();
    this.addEventListener();
  }

  private populateMenu(): void {
    this.getItens();
    const mainUlEl = document.createElement('ul');
    this.menu.forEach((item) => {
      const liEl = document.createElement('li');
      liEl.innerHTML = this.getGroupHtml(item);

      if (item.itens.length > 0) {
        const subUlEl = document.createElement('ul');
        item.itens.forEach((subitem) => {
          const subLiEl = document.createElement('li');
          subLiEl.innerHTML = this.getItemHtml(subitem);
          subUlEl.appendChild(subLiEl);
        });
        liEl.appendChild(subUlEl);
      }

      mainUlEl.appendChild(liEl);
    });

    this.sideMenu.appendChild(mainUlEl);
  }

  private getGroupHtml(item: SideMenuGroup): string {
    return `<a href="${item.url}" class="item-menu flex-row-container flex-center">
              <div class="icon icon-24 icon-text ${item.icon}"></div>
              <div>${item.name}</div>
            </a>`;
  }

  private getItemHtml(item: SideMenuItem): string {
    return `<a href="${item.url}" class="item-menu flex-row-container flex-center">
              <div class="icon icon-24 icon-text icon-chevron-right"></div>
              <div>${item.name}</div>
            </a>`;
  }

  private getItens(): void {
    const grupoPrincipal: SideMenuGroup = {
      icon: 'icon-home',
      name: 'Início',
      url: '/inicio',
      itens: [],
    };

    const grupoTitulo: SideMenuGroup = {
      icon: 'icon-money',
      name: 'Financeiro',
      url: '',
      itens: [
        {
          name: 'Manutenção de Títulos',
          url: '/financeiro/titulos',
        },
      ],
    };

    this.menu.push(grupoPrincipal);
    this.menu.push(grupoTitulo);
  }

  private addEventListener(): void {
    this.sideMenuIcon.addEventListener(
      'click',
      this.hideShowSideMenu.bind(this)
    );
  }

  private hideShowSideMenu(): void {
    if (this.sideMenu.classList.contains('hidden'))
      this.sideMenu.classList.remove('hidden');
    else this.sideMenu.classList.add('hidden');
  }
}

new MainComponent();
