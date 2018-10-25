# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Zoom.Repo.insert!(%Zoom.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Zoom.Repo.insert!(%Zoom.User{name: "Norm Smith", age: 33})
Zoom.Repo.insert!(%Zoom.User{name: "Fred Nurk", age: 22})
