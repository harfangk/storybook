defmodule Storybook.UserTest do
  use Storybook.ModelCase

  alias Storybook.User

  @valid_attrs %{email: "example@example.com", name: "John Doe", username: "jdk412"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset does not accept long usernames" do
    attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 41))
    changeset = User.changeset(%User{}, attrs)
    assert {:username, {"should be at most %{count} character(s)", count: 40}} in changeset.errors
  end

  test "registration_changeset password must be at least 6 characters long" do
    attrs = Map.put(@valid_attrs, :password, "123456")
    changeset = User.registration_changeset(%User{}, attrs)
    assert {:password, {"should be at least %{count} character(s)", count: 6}} in changeset.errors
  end
end
