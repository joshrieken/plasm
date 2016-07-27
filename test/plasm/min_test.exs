defmodule Plasm.MinTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".min with an atom field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 40)
    insert(:user, age: 81)

    # Act
    min = User |> Plasm.min(:age) |> Repo.one

    # Assert
    assert min == 18
  end

  test ".min with a String.t field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 40)
    insert(:user, age: 81)

    # Act
    min = User |> Plasm.min("age") |> Repo.one

    # Assert
    assert min == 18
  end
end
