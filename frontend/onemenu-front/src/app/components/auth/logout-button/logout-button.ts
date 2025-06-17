import { Component, inject } from '@angular/core';
import { AuthService } from '@auth0/auth0-angular';
import { DOCUMENT } from '@angular/common';

// https://auth0.com/docs/quickstart/spa/angular/interactive
@Component({
  selector: 'app-logout-button',
  imports: [],
  templateUrl: './logout-button.html',
  styleUrl: './logout-button.scss',
})
export class LogoutButton {
  private document = inject(DOCUMENT);
  private auth = inject(AuthService);

  logout() {
    this.auth.logout({
      logoutParams: {
        returnTo: this.document.location.origin,
      },
    });
  }
}
