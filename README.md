# rating-db

In this guide we explain how you can download and restore the ratings database. There’s also a short description of its main tables.

## How to use it

### 1. Download backup

Backups are available at https://pub-5200ce7fb4b64b5ea3b6b0b0f05cfcd5.r2.dev/YYYY-MM-DD_rating.backup (replace YYYY-MM-DD with a real date from the past 30 days).

You can run `download.sh` to download a backup from yesterday to `rating.backup` (we create backups around 23:00 UTC, so a backup for today might not exist):

```bash
./download.sh
```

### 2. Run `docker-compose up`

Rename the downloaded file to `rating.backup` and put into the same folder as [`docker-compose.yml`](./docker-compose.yml) and [`restore.sh`](./restore.sh) from this repository. Optionally change user, password, and port variables in `docker-compose.yml` (e.g., if you run already a Postgres instance locally and want this container to use another port). 

Run

```bash
docker-compose up
```

You should now be able to connect to the database using this URI: 

```
postgresql://postgres:password@localhost:5432/postgres
```

### 3. Set up services

For [rating-b](https://github.com/maii-chgk/rating-b) (recalculations), edit `.env`. E.g.:

```
DJANGO_POSTGRES_DB_HOST=localhost
DJANGO_POSTGRES_DB_PORT=5432
DJANGO_POSTGRES_DB_USER=postgres
DJANGO_POSTGRES_DB_PASSWORD=password
DJANGO_POSTGRES_DB_NAME=postgres
DJANGO_SECRET_KEY=asdf
```

For [rating-ui](https://github.com/maii-chgk/rating-ui) (web UI), you can either set the `DATABASE_URL` env variable (e.g., `DATABASE_URL=postgresql://postgres:password@localhost:5432/postgres rails s`) or update `config/database.yml`.

## SQLite

Alternatively, you can download sqlite databases:
- https://pub-5200ce7fb4b64b5ea3b6b0b0f05cfcd5.r2.dev/YYYY-MM-DD_public.sqlite
- https://pub-5200ce7fb4b64b5ea3b6b0b0f05cfcd5.r2.dev/YYYY-MM-DD_b.sqlite

They are split by schema: `public` and `b` ([see below](#whats-in-there)). They will not work for running rating-b or rating-ui, but might be more suitable for ad-hoc data exploration.

## What’s in there

Two schemas: `b` and `public`. `public` has data about tournaments, results, and rosters that we sync from [rating.chgk.info](https://rating.chgk.info). rating-b calculates ratings and stores them in the `b` schema.

### `public`

Most of these tables are populated by [rating-importer](https://github.com/maii-chgk/rating-importer) using data from [rating.chgk.info](https://rating.chgk.info). Ignore `auth_*`, `django_*`, and `schema_migrations` tables.

| Table Name                     | Comment                                                                                               |
|--------------------------------|-------------------------------------------------------------------------------------------------------|
| base_rosters                   |                                                                                                       |
| models                         | rating-ui internal table, list of models (schemas) in the database                                    |
| ndcg                           | WIP: we’ll use it to [compare models in the future](https://en.wikipedia.org/wiki/Discounted_cumulative_gain) |
| players                        |                                                                                                       |
| rating_individual_old          | We use ratings from April 2020 as a starting point.                                                   |
| rating_individual_old_details  | We use ratings from April 2020 as a starting point.                                                   |
| rosters                        |                                                                                                       |
| seasons                        |                                                                                                       |
| teams                          |                                                                                                       |
| tournament_results             |                                                                                                       |
| tournament_rosters             |                                                                                                       |
| tournaments                    |                                                                                                       |
| towns                          |                                                                                                       |

### `b`

rating-b’s tables are in its [`models.py`](https://github.com/maii-chgk/rating-b/blob/main/b/models.py).
