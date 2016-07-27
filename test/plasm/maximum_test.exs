defmodule Plasm.MaximumTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".maximum with an atom field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 40)
    insert(:user, age: 81)

    # Act
    maximum = User |> Plasm.maximum(:age) |> Repo.one

    # Assert
    assert maximum == 81
  end

  test ".maximum with a String.t field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 40)
    insert(:user, age: 81)

    # Act
    maximum = User |> Plasm.maximum("age") |> Repo.one

    # Assert
    assert maximum == 81
  end
end
