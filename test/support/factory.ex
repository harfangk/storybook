defmodule Storybook.Factory do
  use ExMachina.Ecto, repo: Storybook.Repo

  def user_factory do
    %Storybook.User{
      username: "JSON Mraz",
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "password",
      password_hash: Comeonin.Bcrypt.hashpwsalt("password") 
    }
  end
end
