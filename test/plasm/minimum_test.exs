defmodule Plasm.MinimumTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".minimum with an atom field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 40)
    insert(:user, age: 81)

    # Act
    minimum = User |> Plasm.minimum(:age) |> Repo.one

    # Assert
    assert minimum == 18
  end

  test ".minimum with a String.t field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 40)
    insert(:user, age: 81)

    # Act
    minimum = User |> Plasm.minimum("age") |> Repo.one

    # Assert
    assert minimum == 18
  end
end
