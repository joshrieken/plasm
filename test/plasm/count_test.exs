defmodule Plasm.CountTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".count" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 18)
    insert(:user, age: 81)

    # Act
    count = User |> Plasm.count |> Repo.one

    # Assert
    assert count == 3
  end
end
