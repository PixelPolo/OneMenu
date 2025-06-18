import { Routes } from '@angular/router';
import { Home } from './components/home/home';
import { NotFound } from './components/not-found/not-found';
import { authGuard } from '../guards/auth/auth-guard';

export const routes: Routes = [
  {
    path: '',
    redirectTo: '/home',
    pathMatch: 'full',
  },
  {
    path: 'home',
    component: Home,
    title: 'Home',
  },
  {
    path: '404',
    component: NotFound,
    title: '404'
  },
  {
    path: '**',
    redirectTo: '404'
  },
];
