defmodule Storybook.UserBook do
  use Storybook.Web, :model

  @primary_key false
  schema "user_books" do
    belongs_to :user, Storybook.User
    belongs_to :book, Storybook.Book

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :book_id])
    |> validate_required([:user_id, :book_id])
  end
end
