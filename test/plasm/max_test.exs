defmodule Plasm.MaxTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".max with an atom field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 40)
    insert(:user, age: 81)

    # Act
    max = User |> Plasm.max(:age) |> Repo.one

    # Assert
    assert max == 81
  end

  test ".max with a String.t field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 40)
    insert(:user, age: 81)

    # Act
    max = User |> Plasm.max("age") |> Repo.one

    # Assert
    assert max == 81
  end
end
