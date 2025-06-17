import { Component, inject } from '@angular/core';
import { AuthService } from '@auth0/auth0-angular';

// https://auth0.com/docs/quickstart/spa/angular/interactive
@Component({
  selector: 'app-login-button',
  imports: [],
  templateUrl: './login-button.html',
  styleUrl: './login-button.scss',
})
export class LoginButton {
  private auth = inject(AuthService);

  login() {
    // *** loginWithRedirect -> BUG ***
    // *** this.auth.isAuthenticated$ -> always false ***
    // this.auth.loginWithRedirect();
    this.auth.loginWithPopup();
  }
}
