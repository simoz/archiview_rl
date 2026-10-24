# Database

[English](../en/database.md)

Schema, migrazioni e dati appartengono ad archimate.

## Sviluppo e test

In sviluppo si usa la stessa configurazione PostgreSQL locale di archimate: database `archimate_development`, utente locale e nessun ruolo dedicato. Modelli e controller non aggiungono controlli di sola lettura.

`database_tasks: false` esclude il database di archimate dai task Rails di questa app. Il database di test `archiview_rl_test` è separato e scrivibile: `bin/rails db:test:prepare` lo prepara dalla copia di `db/schema.rb`.

## Produzione

Al rilascio configurare un ruolo dedicato che possa soltanto leggere le tabelle. Il ruolo non deve essere superuser, proprietario delle tabelle o membro di un ruolo con permessi di scrittura.

Come amministratore, collegarsi al database di produzione di archimate ed eseguire una sola volta i comandi seguenti, adattando il nome del database e sostituendo `<archimate_owner>` con il ruolo che crea le tabelle:

```sql
CREATE ROLE archiview_rl LOGIN;
GRANT CONNECT ON DATABASE archimate_production TO archiview_rl;
GRANT USAGE ON SCHEMA public TO archiview_rl;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO archiview_rl;
ALTER DEFAULT PRIVILEGES FOR ROLE <archimate_owner> IN SCHEMA public
  GRANT SELECT ON TABLES TO archiview_rl;
```

I privilegi predefiniti valgono per le tabelle e le viste create successivamente dal proprietario indicato. Se il ruolo esiste già, verificarne i permessi prima di riutilizzarlo. Configurare l’autenticazione richiesta dal server, impostando `ARCHIVIEW_RL_DATABASE_PASSWORD` se serve una password.

La configurazione locale `config/database.yml` non è versionata. Anche in produzione `database_tasks: false` esclude il database di archimate dai task Rails di questa app.
