defmodule Plasm.WhereNoneTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".where_none with one field" do
    # Arrange
    bill1 = insert(:user, age: 18, name: "Bill")
    bill2 = insert(:user, age: 81, name: "Bill")
    bob = insert(:user, age: 40, name: "Bob")

    # Act
    users = User |> Plasm.where_none(name: "Bill") |> Repo.all

    # Assert
    assert Enum.member?(users, bob)
    refute Enum.member?(users, bill1)
    refute Enum.member?(users, bill2)
  end

  test ".where_none with two fields" do
    # Arrange
    bill = insert(:user, age: 18, name: "Bill")
    john = insert(:user, age: 81, name: "John")
    bob = insert(:user, age: 40, name: "Bob")

    # Act
    users = User |> Plasm.where_none(name: "Bill", age: 81) |> Repo.all

    # Assert
    assert Enum.member?(users, bob)
    refute Enum.member?(users, bill)
    refute Enum.member?(users, john)
  end
end
