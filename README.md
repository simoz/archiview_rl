# archiview_rl

[Italiano](README.it.md)

Aggregated archives portal. The portal will aggregate published records and support browsing by workspace with a consistent presentation. Data and schema belong to archimate.

This initial version contains the Rails foundation and a temporary bilingual home page. Archive browsing, search and product-specific features still need to be implemented.

## Development

Ruby 3.4.8, Rails 8.1, PostgreSQL and an archimate checkout at `../archimate` (or the path specified by `ARCHIMATE_PATH`) are required. The schema is copied from archimate only to prepare tests.

1. Run `bin/setup --skip-server`: it installs dependencies, copies `config/database.yml.example` when local configuration is missing, updates the test schema, prepares the test database and compiles Sass.
2. Start `bin/dev` and open [localhost:3002](http://localhost:3002). Set `PORT` to use another port.

`bin/dev` starts Rails and the Sass watcher. The foundation uses Propshaft, Dart Sass and Bootstrap; JavaScript can be added when a page needs it, following archimate conventions.

## Database and configuration

- Development: `archimate_development`, using the same local PostgreSQL connection as archimate, without a dedicated role.
- Tests: `archiview_rl_test`, writable and separate from archimate data. Override its name with `ARCHIVIEW_RL_TEST_DATABASE`.
- Production: `archimate_production`, using a read-only role to be configured on the server; see [Database](docs/en/database.md).
- `ARCHIMATE_DATABASE`, `ARCHIVIEW_RL_DATABASE_USERNAME` and `ARCHIVIEW_RL_DATABASE_PASSWORD` configure the production connection. Set the host and other options in the local `config/database.yml`.
- `database_tasks: false` excludes development and production from Rails database tasks. There are no local migrations: schema changes belong to archimate.

In production, PostgreSQL permissions will enforce read-only access. Development uses archimate’s local configuration. Models and controllers use ordinary Rails behavior, without additional write guards. Visitors receive no sessions or cookies; the locale is in the URL (`?locale=en`, Italian by default).

## Verification

```sh
bin/rails test
bin/rubocop
bin/brakeman -q
```

`bin/ci` runs setup, static checks, dependency auditing and tests. After an archimate schema change, run `bin/rails archimate:schema` and `bin/rails db:test:prepare`.

## Deployment

Configure the server connection with the read-only role, an application-specific `SECRET_KEY_BASE`, and the HTTPS host in the web server. Compile assets with `RAILS_ENV=production bin/rails assets:precompile`. Public domain configuration will be completed alongside product features.
