defmodule Storybook.User do
  use Storybook.Web, :model

  schema "users" do
    field :email, :string
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :name, :username])
    |> validate_required([:email, :name, :username])
  end
end
