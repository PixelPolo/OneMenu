export const environment = {
  production: false,
  AUTH0_DOMAIN: (window as any).__env?.AUTH0_DOMAIN,
  AUTH0_CLIENT_ID: (window as any).__env?.AUTH0_CLIENT_ID,
};
