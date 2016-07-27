defmodule Plasm.RandomTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".random" do
    # Arrange
    users = [
      insert(:user, age: 18),
      insert(:user, age: 40),
      insert(:user, age: 81),
    ]

    # Act
    user = User |> Plasm.random |> Repo.one

    # Assert
    assert Enum.member?(users, user)
  end

  test ".random with a count" do
    # Arrange
    users = [
      insert(:user, age: 18),
      insert(:user, age: 40),
      insert(:user, age: 81),
    ]

    # Act
    random_users = User |> Plasm.random(2) |> Repo.all

    # Assert
    assert Enum.count(random_users) == 2
    assert Enum.member?(users, Enum.at(random_users, 0))
    assert Enum.member?(users, Enum.at(random_users, 1))
  end
end
