# dbt (FreeCodeCamp lesson)

This project targets the **destination** Postgres started by Docker Compose (`destination_db` on `localhost:5434` after the ELT job has loaded data).

1. Start the stack and wait for the ELT container to finish: from the repo root run `docker compose up` (or `docker compose up -d` and check logs).
2. Create a Python virtualenv at the repo root and install dbt: `python3 -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt`
3. Install your profile, either:
   - `mkdir -p ~/.dbt && cp profiles.yml.example ~/.dbt/profiles.yml`, or
   - `cp profiles.yml.example profiles.yml` in this folder (`profiles.yml` is gitignored) and pass `--profiles-dir .` to dbt.
4. From this directory run:

```bash
dbt debug
dbt run
```

Models are created in the `analytics` schema (see `profiles.yml.example`). Raw tables remain in `public`.
