defmodule Storybook.Book do
  use Storybook.Web, :model

  schema "books" do
    field :title, :string
    field :authors, {:array, :string}
    field :Publisher, :string
    field :published_date, :string
    field :description, :string
    field :isbn10, :string
    field :isbn13, :string
    field :image_thumbnail, :string
    field :image_regular, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :authors, :Publisher, :published_date, :description, :isbn10, :isbn13, :image_thumbnail, :image_regular])
    |> validate_required([:title])
  end
end
