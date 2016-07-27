defmodule Plasm.CountDistinctTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".count_distinct with an atom field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 18)
    insert(:user, age: 81)

    # Act
    count = User |> Plasm.count_distinct(:age) |> Repo.one

    # Assert
    assert count == 2
  end

  test ".count_distinct with a String.t field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 18)
    insert(:user, age: 81)

    # Act
    count = User |> Plasm.count_distinct("age") |> Repo.one

    # Assert
    assert count == 2
  end
end
