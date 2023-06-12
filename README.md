# Promise

This service is now running on two domains:
[test](https://test.promise.waika28.ru) and
[production](https://promise.waika28.ru). The documentation is on `/docs`
[here](https://test.promise.waika28.ru/docs) and
[here](https://promise.waika28.ru/docs) respectively.

# Developing

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
