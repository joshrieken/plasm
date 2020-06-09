defmodule Plasm.FindTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".find with a list" do
    # Arrange
    user1 = insert(:user, age: 18)
    user2 = insert(:user, age: 18)
    user3 = insert(:user, age: 81)

    # Act
    users = User |> Plasm.find([user1.id, user2.id]) |> Repo.all

    # Assert
    assert Enum.member?(users, user1)
    assert Enum.member?(users, user2)
    refute Enum.member?(users, user3)
  end

  test ".find with an integer" do
    # Arrange
    user1 = insert(:user, age: 18)
    insert(:user, age: 18)
    insert(:user, age: 81)

    # Act
    user = User |> Plasm.find(user1.id) |> Repo.one

    # Assert
    assert user == user1
  end

  test ".find with an integer and a prior query" do
    # Arrange
    user1 = insert(:user, age: 18)
    insert(:user, age: 18)
    insert(:user, age: 81)

    # Act
    user = User |> User.for_age(18) |> Plasm.find(user1.id) |> Repo.one

    # Assert
    assert user == user1
  end
end
