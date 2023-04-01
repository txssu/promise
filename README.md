# Promise

To start:

```bash
docker compose up --remove-orphans --build
```

- `http://localhost:4000` — backend
- `http://localhost:4001` — documentation
- `http://localhost:4002` — pgadmin

After first run you need to:
```bash
docker compose exec promise mix ecto.setup
```
