# Database

[Italiano](../it/database.md)

Schema, migrations and data belong to archimate.

## Development and tests

Development uses archimate’s local PostgreSQL configuration: the `archimate_development` database, the local user and no dedicated role. Models and controllers do not add read-only checks.

`database_tasks: false` excludes the archimate database from this app’s Rails tasks. The `archiview_rl_test` test database is separate and writable: `bin/rails db:test:prepare` prepares it from the copied `db/schema.rb`.

## Production

At deployment, configure a dedicated role that can only read tables. The role must not be a superuser, table owner or member of a role with write privileges.

As an administrator, connect to archimate’s production database and run the following once, adapting the database name and replacing `<archimate_owner>` with the role that creates tables:

```sql
CREATE ROLE archiview_rl LOGIN;
GRANT CONNECT ON DATABASE archimate_production TO archiview_rl;
GRANT USAGE ON SCHEMA public TO archiview_rl;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO archiview_rl;
ALTER DEFAULT PRIVILEGES FOR ROLE <archimate_owner> IN SCHEMA public
  GRANT SELECT ON TABLES TO archiview_rl;
```

Default privileges apply to tables and views subsequently created by the specified owner. If the role already exists, verify its privileges before reusing it. Configure the authentication required by the server, setting `ARCHIVIEW_RL_DATABASE_PASSWORD` when a password is needed.

Local `config/database.yml` is not versioned. In production, `database_tasks: false` also excludes the archimate database from this app’s Rails tasks.
