import { Component, effect, inject } from '@angular/core';
import { LoginButton } from '../auth/login-button/login-button';
import { LogoutButton } from '../auth/logout-button/logout-button';
import { AuthService } from '@auth0/auth0-angular';
import { filter, firstValueFrom } from 'rxjs';
import { toSignal } from '@angular/core/rxjs-interop';

@Component({
  selector: 'app-home',
  imports: [LoginButton, LogoutButton],
  templateUrl: './home.html',
  styleUrl: './home.scss',
})
export class Home {
  private auth = inject(AuthService);
  private userSignal = toSignal(this.auth.user$);
  constructor() {
    effect(() => {
      const user = this.userSignal();
      if (user) console.log(user.email);
    });
  }
}
