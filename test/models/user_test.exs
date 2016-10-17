defmodule Storybook.UserTest do
  use Storybook.ModelCase, async: true

  alias Storybook.User

  @valid_attrs %{email: "example@example.com", username: "jdk412", password: "thisispassword"}
  @invalid_attrs %{}

  test "create_changeset with valid attributes" do
    changeset = User.create_changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "create_changeset with invalid attributes" do
    changeset = User.create_changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "create_changeset does not accept long usernames" do
    attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 41))
    changeset = User.create_changeset(%User{}, attrs)
    assert {:username, {"should be at most %{count} character(s)", count: 40}} in changeset.errors
  end

  test "create_changeset password must be at least 6 characters long" do
    attrs = Map.put(@valid_attrs, :password, "12345")
    changeset = User.create_changeset(%User{}, attrs)
    assert {:password, {"should be at least %{count} character(s)", count: 6}} in changeset.errors
  end
end
