defmodule Storybook.Factory do
  use ExMachina.Ecto, repo: Storybook.Repo

  def user_factory do
    %Storybook.User{
      username: "JSON Mraz",
      email: sequence(:email, &"email-#{&1}@example.com"),
      password_hash: sequence(:password_hash, &"hashed_password#{&1}")
    }
  end
end
