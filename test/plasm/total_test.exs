defmodule Plasm.TotalTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".total with an atom field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 40)
    insert(:user, age: 81)

    # Act
    total = User |> Plasm.total(:age) |> Repo.one

    # Assert
    assert total == 139
  end

  test ".total with a String.t field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 40)
    insert(:user, age: 81)

    # Act
    total = User |> Plasm.total("age") |> Repo.one

    # Assert
    assert total == 139
  end
end
