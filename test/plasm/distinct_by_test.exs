defmodule Plasm.DistinctByTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".distinct_by with an atom field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 18)
    insert(:user, age: 81)

    # Act
    users = User |> Plasm.distinct_by(:age) |> Repo.all

    # Assert
    assert Enum.count(users) == 2
  end

  test ".distinct_by with a String.t field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 18)
    insert(:user, age: 81)

    # Act
    users = User |> Plasm.distinct_by("age") |> Repo.all

    # Assert
    assert Enum.count(users) == 2
  end
end
