# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Storybook.Repo.insert!(%Storybook.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Storybook.Repo
alias Storybook.User

Repo.insert! %User{name: "Nasim Taleb", username: "Black swan", password_hash: "skeptical_empiricist", email: "taleb@nasim.com"}
Repo.insert! %User{name: "Devin", username: "Runnner", password_hash: "runnershigh", email: "bluesky@naver.com"}
Repo.insert! %User{name: "Monitor", username: "Monitorer", password_hash: "Boomdiada!", email: "Dort@dora.de"}
