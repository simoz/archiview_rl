# archiview_rl

[English](README.md)

Portale di cumulazione degli archivi. Il portale riunirà i dati pubblicati e permetterà di consultarli anche per workspace, con una presentazione uniforme. I dati e lo schema appartengono ad archimate.

Questa prima versione contiene la base Rails e una home provvisoria bilingue. La consultazione degli archivi, la ricerca e le funzioni specifiche del prodotto devono ancora essere implementate.

## Sviluppo

Servono Ruby 3.4.8, Rails 8.1, PostgreSQL e una copia di archimate in `../archimate` (oppure indicata da `ARCHIMATE_PATH`). Lo schema viene copiato da archimate soltanto per preparare i test.

1. Eseguire `bin/setup --skip-server`: installa le dipendenze, copia `config/database.yml.example` se manca la configurazione locale, aggiorna lo schema dei test, prepara il database di test e compila Sass.
2. Avviare `bin/dev` e aprire [localhost:3002](http://localhost:3002). `PORT` permette di scegliere un’altra porta.

`bin/dev` avvia Rails e la compilazione Sass. La base usa Propshaft, Dart Sass e Bootstrap; JavaScript si aggiunge quando una pagina ne ha bisogno, seguendo le convenzioni di archimate.

## Database e configurazione

- Sviluppo: `archimate_development`, con la stessa connessione PostgreSQL locale di archimate, senza un ruolo dedicato.
- Test: `archiview_rl_test`, scrivibile e separato dai dati di archimate. Si può cambiarne il nome con `ARCHIVIEW_RL_TEST_DATABASE`.
- Produzione: `archimate_production`, con un ruolo di sola lettura da configurare sul server; vedi [Database](docs/it/database.md).
- `ARCHIMATE_DATABASE`, `ARCHIVIEW_RL_DATABASE_USERNAME` e `ARCHIVIEW_RL_DATABASE_PASSWORD` configurano la connessione in produzione. Per host e altre opzioni modificare il file locale `config/database.yml`.
- `database_tasks: false` esclude sviluppo e produzione dai task Rails del database. Qui non si creano migrazioni: i cambiamenti allo schema appartengono ad archimate.

In produzione la sola lettura sarà garantita dai permessi PostgreSQL. In sviluppo si usa la configurazione locale di archimate. I modelli e i controller sono quelli ordinari di Rails, senza blocchi aggiuntivi sulle scritture. I visitatori non hanno sessioni né cookie; la lingua è nella URL (`?locale=en`, italiano predefinito).

## Verifica

```sh
bin/rails test
bin/rubocop
bin/brakeman -q
```

`bin/ci` esegue preparazione, controlli statici, verifica delle dipendenze e test. Dopo un cambiamento allo schema di archimate eseguire `bin/rails archimate:schema` e `bin/rails db:test:prepare`.

## Rilascio

Sul server configurare la connessione con il ruolo di sola lettura, una chiave `SECRET_KEY_BASE` propria dell’app e l’host HTTPS nel server web. Compilare gli asset con `RAILS_ENV=production bin/rails assets:precompile`. La configurazione dei domini pubblici sarà completata insieme alle funzioni del prodotto.
