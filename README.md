# Promise

To start:

```bash
docker compose up --remove-orphans --build
```

or just `./start.sh`

Now you can open `http://localhost:80`

After changes in database you need to run migrations:

```bash
docker compose exec promise mix ecto.migrate
```
