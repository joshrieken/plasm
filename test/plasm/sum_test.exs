defmodule Plasm.SumTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".sum with an atom field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 40)
    insert(:user, age: 81)

    # Act
    sum = User |> Plasm.sum(:age) |> Repo.one

    # Assert
    assert sum == 139
  end

  test ".sum with a String.t field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 40)
    insert(:user, age: 81)

    # Act
    sum = User |> Plasm.sum("age") |> Repo.one

    # Assert
    assert sum == 139
  end
end
