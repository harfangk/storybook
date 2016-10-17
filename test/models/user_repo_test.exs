defmodule Storybook.UserRepoTest do
  use Storybook.ModelCase
  import Storybook.Factory
  alias Storybook.User

  @attrs %{email: "email@test.com", username: "user", password: "password"}

  test "converts unique_constraint on username to error" do
    insert(:user, [username: "unique_username"])
    attrs = Map.put(@attrs, :username, "unique_username")
    changeset = User.registration_changeset(%User{}, attrs)

    assert {:error, changeset} = Repo.insert(changeset)
    assert {:username, {"has already been taken", []}} in changeset.errors
  end

  test "converts unique_constraint on email to error" do
    insert(:user, [email: "unique_email@test.com"])
    attrs = Map.put(@attrs, :email, "unique_email@test.com")
    changeset = User.registration_changeset(%User{}, attrs)

    assert {:error, changeset} = Repo.insert(changeset)
    assert {:email, {"has already been taken", []}} in changeset.errors
  end
end
