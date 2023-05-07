# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Promise.Repo.insert!(%Promise.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Promise.Repo
alias Promise.Accounts.User

%User{}
|> User.registration(%{
  first_name: "Piotr",
  last_name: "Makarov",
  email: "piotr.makarov@gmail.com",
  password: "123456789"
})
|> Repo.insert!()

%User{}
|> User.registration(%{
  first_name: "Евгений",
  last_name: "Рыбин",
  email: "z.ribin20@gmail.com",
  password: "123456789"
})
|> Repo.insert!()

%User{}
|> User.registration(%{
  first_name: "Eugene",
  last_name: "Fisher",
  email: "g.fisher20@gmail.com",
  password: "123456789"
})
|> Repo.insert!()

%User{}
|> User.registration(%{
  first_name: "Константин",
  last_name: "Константинопольский",
  email: "kosta@mail.ru",
  password: "123456789"
})
|> Repo.insert!()
