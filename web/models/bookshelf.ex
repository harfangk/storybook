defmodule Storybook.Bookshelf do
  use Storybook.Web, :model

  schema "bookshelves" do
    field :name, :string
    field :description, :string
    belongs_to :user, Storybook.User
    many_to_many :books, Storybook.Book, join_through: Storybook.BookshelfBook

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name])
  end
end
