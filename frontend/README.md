# OneMenu Angular Client

OneMenu is a collaborative meal planning app designed to help users create a shared.  
menu by allowing invited guests to vote on various starters, main courses, desserts, and more.  
An optimization algorithm processes all the votes and selects the menu that  
maximizes overall satisfaction across the group — ideal for events, dinners, and parties.

## Features

- Create voting sessions for menus
- Invite guests to participate
- Choose from multiple dishes (starters, mains, desserts, etc.)
- Intelligent algorithm picks the best global combination
- User authentication & session management
- Mobile-first frontend experience

This project was generated using [Angular CLI](https://github.com/angular/angular-cli) version 20.0.2.

## Development server

To start a local development server, run:

```bash
ng serve
```

Once the server is running, open your browser and navigate to `http://localhost:4200/`.  
The application will automatically reload whenever you modify any of the source files.

## Code scaffolding

Angular CLI includes powerful code scaffolding tools. To generate a new component, run:

```bash
ng generate component component-name
```

For a complete list of available schematics (such as `components`, `directives`, or `pipes`), run:

```bash
ng generate --help
```

## Building

To build the project run:

```bash
ng build
```

This will compile your project and store the build artifacts in the `dist/` directory. By default, the production build optimizes your application for performance and speed.

## Running unit tests

To execute unit tests with the [Karma](https://karma-runner.github.io) test runner, use the following command:

```bash
ng test
```

## Running end-to-end tests

For end-to-end (e2e) testing, run:

```bash
ng e2e
```

Angular CLI does not come with an end-to-end testing framework by default.  
You can choose one that suits your needs.  
Not implemented here.

## Additional Resources

For more information on using the Angular CLI, including detailed command references,  
visit the [Angular CLI Overview and Command Reference](https://angular.dev/tools/cli) page.

## Handling Environment Variables in Angular (Public Git + Docker)

Managing environment variables securely in an Angular app — especially when using a **public Git repository**  
and deploying via a hosting provider — requires a runtime-based solution.

### Solution Overview

- Create a file `env.template.js` inside the `public/` folder with placeholder variables:

    ```js
    // Runtime environment variables injected at container startup
    window.__env = {
    AUTH0_DOMAIN: "$AUTH0_DOMAIN",
    AUTH0_CLIENT_ID: "$AUTH0_CLIENT_ID",
    };
    ```

- To make those variables accessible inside your Angular components and services,  
update your `src/environments/environment.ts` like so:

    ```ts
    export const environment = {
    production: false,
    AUTH0_DOMAIN: (window as any).__env?.AUTH0_DOMAIN,
    AUTH0_CLIENT_ID: (window as any).__env?.AUTH0_CLIENT_ID,
    };
    ```

- Reference the generated file in `index.html`:

    ```html
    <script src="public/env.js"></script>
    ```

- Use an entrypoint script in Docker to inject environment values at runtime:

    ```bash
    #!/bin/sh

    # Generate env.js from env.template.js
    envsubst < /usr/share/nginx/html/public/env.template.js > /usr/share/nginx/html/public/env.js

    # Start NGINX
    nginx -g 'daemon off;'
    ```

- Add the script and template to your Dockerfile:  
This setup is inspired by [this article](https://dextrop.medium.com/containerizing-a-angular-application-using-docker-a71968269821).

    ```Dockerfile
    # ---------- STAGE 1: Build the Angular app ----------
    FROM node:20 AS builder

    # Set working directory
    WORKDIR /app

    # Install dependencies
    COPY package*.json ./
    RUN npm install

    # Copy full source code
    COPY . .

    # Build Angular app in production mode
    RUN npm run build --prod

    # ---------- STAGE 2: Serve the built app with NGINX ----------
    FROM nginx:alpine

    # Copy Angular build to NGINX HTML folder
    COPY --from=builder /app/dist/onemenu-front/browser /usr/share/nginx/html

    # Copy NGINX configuration
    COPY nginx.conf /etc/nginx/conf.d/default.conf

    # Copy env.template.js and entrypoint script
    COPY public/env.template.js /usr/share/nginx/html/public/env.template.js
    COPY entrypoint.sh /entrypoint.sh
    RUN chmod +x /entrypoint.sh

    # Expose HTTP port
    EXPOSE 80

    # Inject env vars and run NGINX
    ENTRYPOINT ["/entrypoint.sh"]
    ```

- For local development or testing, you can create a `.env` file containing your environment variables:

    ```env
    AUTH0_DOMAIN=yourdomain.auth0.com
    AUTH0_CLIENT_ID=your-client-id
    ```

- You can then use the following `rundocker.sh` script to build and run the container:

    ```bash
    #!/bin/bash

    # Load env vars
    if [ -f .env ]; then
    export $(grep -E '^(AUTH0_DOMAIN|AUTH0_CLIENT_ID)=' .env | xargs)
    fi

    # Check required vars
    missing_vars=()
    [ -z "$AUTH0_DOMAIN" ] && missing_vars+=("AUTH0_DOMAIN")
    [ -z "$AUTH0_CLIENT_ID" ] && missing_vars+=("AUTH0_CLIENT_ID")

    if [ ${#missing_vars[@]} -ne 0 ]; then
    echo "Missing required environment variables: ${missing_vars[*]}"
    exit 1
    fi

    # Build
    docker build -t onemenu-front .

    # Run
    docker run --rm --name onemenu-front-container -p 4200:80 \
    -e AUTH0_DOMAIN="$AUTH0_DOMAIN" \
    -e AUTH0_CLIENT_ID="$AUTH0_CLIENT_ID" \
    onemenu-front
    ```
