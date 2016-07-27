defmodule Plasm.AvgTest do
  use Plasm.Case

  alias Decimal, as: D

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".avg with an atom field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 40)
    insert(:user, age: 81)

    # Act
    avg = User |> Plasm.avg(:age) |> Repo.one

    # Assert
    D.set_context(%D.Context{D.get_context | precision: 18})
    assert avg == D.div(D.new(139), D.new(3))
  end

  test ".avg with a String.t field name" do
    # Arrange
    insert(:user, age: 18)
    insert(:user, age: 40)
    insert(:user, age: 81)

    # Act
    avg = User |> Plasm.avg("age") |> Repo.one

    # Assert
    D.set_context(%D.Context{D.get_context | precision: 18})
    assert avg == D.div(D.new(139), D.new(3))
  end
end
