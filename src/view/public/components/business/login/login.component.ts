export class LoginComponent {
  btnLogin = document.getElementById('btnLogin');
  btnCloseAlertLogin = document.getElementById('closeAlertLogin');
  loginInput = document.getElementById('loginInput') as HTMLInputElement;
  passwordInput = document.getElementById('passwordInput') as HTMLInputElement;
  alertLogin = document.getElementById('alertLogin');
  messageLogin = document.getElementById('messageLogin');

  constructor() {
    this.btnLogin?.addEventListener('click', this.loginAction.bind(this));
    this.btnCloseAlertLogin?.addEventListener(
      'click',
      this.closeAlertLogin.bind(this)
    );
  }

  loginAction() {
    const errors: string[] = [];

    if (!this.loginInput?.value) errors.push('O login não pode ser em branco');

    if (!this.passwordInput?.value)
      errors.push('A senha não pode ser em branco');

    if (errors.length > 0) {
      this.alertLogin?.classList.remove('hidden');

      if (this.messageLogin) this.messageLogin.innerHTML = errors.join('<br>');

      return;
    }

    const access = btoa(this.loginInput.value + '#' + this.passwordInput.value);
    window.location.href = '/titulos';
  }

  closeAlertLogin() {
    if (this.messageLogin) this.messageLogin.innerHTML = '';

    this.alertLogin?.classList.add('hidden');
  }
}

new LoginComponent();
