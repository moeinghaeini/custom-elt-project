# Custom ELT Project

This repository contains a custom Extract, Load, Transform (ELT) project that utilizes Docker and PostgreSQL to demonstrate a simple ELT process.

## Repository Structure

1. **docker-compose.yaml**: This file contains the configuration for Docker Compose, which is used to orchestrate multiple Docker containers. It defines three services:
   - `source_postgres`: The source PostgreSQL database.
   - `destination_postgres`: The destination PostgreSQL database.
   - `elt_script`: The service that runs the ELT script.

2. **elt_script/Dockerfile**: This Dockerfile sets up a Python environment and installs the PostgreSQL client. It also copies the ELT script into the container and sets it as the default command.

3. **elt_script/elt_script.py**: This Python script performs the ELT process. It waits for the source PostgreSQL database to become available, then dumps its data to a SQL file and loads this data into the destination PostgreSQL database.

4. **source_db_init/init.sql**: This SQL script initializes the source database with sample data. It creates tables for users, films, film categories, actors, and film actors, and inserts sample data into these tables.

## How It Works

1. **Docker Compose**: Using the `docker-compose.yaml` file, three Docker containers are spun up:
   - A source PostgreSQL database with sample data.
   - A destination PostgreSQL database.
   - A Python environment that runs the ELT script.

2. **ELT Process**: The `elt_script.py` waits for the source PostgreSQL database to become available. Once it's available, the script uses `pg_dump` to dump the source database to a SQL file. Then, it uses `psql` to load this SQL file into the destination PostgreSQL database.

3. **Database Initialization**: The `init.sql` script initializes the source database with sample data. It creates several tables and populates them with sample data.

## Getting Started

1. Install [Docker](https://docs.docker.com/get-started/) and start Docker Desktop (macOS/Windows) or the Docker daemon (Linux). Use `docker compose version` to confirm Compose v2.
2. Clone this repository.
3. From the repository directory run `docker compose up --build`.
4. When the `elt_script` service exits successfully, the load is complete. Postgres keeps running until you stop Compose; source is on port **5433**, destination on **5434** (user/password: `postgres` / `secret`).

## FreeCodeCamp data engineering course

Official companion resources ( explanations, copy-paste snippets ): [FreeCodeCamp Data Engineering Course Resources](https://transparent-trout-f2f.notion.site/FreeCodeCamp-Data-Engineering-Course-Resources-e9d2b97aed5b4d4a922257d953c4e759).

| Topic | Notion lesson |
|-------|----------------|
| SQL | [SQL](https://transparent-trout-f2f.notion.site/SQL-7bc979523659472d8c2b6e36e64ff113) |
| This ELT pipeline | [Creating a Data Pipeline from Scratch](https://transparent-trout-f2f.notion.site/Creating-a-Data-Pipeline-from-Scratch-79164f9e63de482284a9c15b30af567d) |
| dbt | [dbt](https://transparent-trout-f2f.notion.site/dbt-65d25d721870440c82a491e883f85c6c) — use the `dbt/` folder in this repo |
| Airflow | [Airflow](https://transparent-trout-f2f.notion.site/Airflow-0328f9ac3fd84001835a00ec9bd6c25a) and [Airflow DC Structure](https://transparent-trout-f2f.notion.site/Airflow-DC-Structure-d97053d335cf48a5906e5fc002540451) |
| Airbyte | [Airbyte](https://transparent-trout-f2f.notion.site/Airbyte-8aba108853c74126a338fe890422a737) — clone [airbytehq/airbyte](https://github.com/airbytehq/airbyte) and follow their Docker instructions; UI at `http://localhost:8000` |

**Git:** [Course repo (this project)](https://github.com/justinbchau/custom-elt-project/tree/main)

### Python and dbt (optional, for the dbt module)

dbt 1.8 needs **Python 3.9–3.12**. If your default `python3` is newer (for example 3.14), install 3.12 and create the virtualenv with that interpreter (on macOS with Homebrew: `brew install python@3.12`).

```bash
/opt/homebrew/bin/python3.12 -m venv .venv   # adjust path if needed
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

Then follow [`dbt/README.md`](dbt/README.md).

### Re-running the ELT job on a clean destination

If Postgres data volumes already exist from a previous run, replaying the dump can hit “already exists” errors. Reset volumes and start again:

```bash
docker compose down -v
docker compose up --build
```

### Airbyte OSS (separate install)

Airbyte is not bundled here. With Docker available, clone the [Airbyte repo](https://github.com/airbytehq/airbyte) into another directory and use their `docker compose` workflow so the stack does not conflict with this project’s ports.