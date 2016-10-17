defmodule Storybook.UserTest do
  use Storybook.ModelCase, async: true

  alias Storybook.User

  @valid_attrs %{email: "example@example.com", username: "jdk412"}
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
    attrs = Map.put(@valid_attrs, :password, "12345")
    changeset = User.registration_changeset(%User{}, attrs)
    assert {:password, {"should be at least %{count} character(s)", count: 6}} in changeset.errors
  end

  test "registration_changeset with valid attributes hashes password" do
    attrs = Map.put(@valid_attrs, :password, "12345667890")
    changeset = User.registration_changeset(%User{}, attrs)
    %{password: password, password_hash: password_hash} = changeset.changes

    assert changeset.valid?
    assert password_hash
    assert Comeonin.Bcrypt.checkpw(password, password_hash)
  end
end
