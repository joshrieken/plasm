defmodule Plasm.WhereAllTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".where_all with one field" do
    # Arrange
    bill1 = insert(:user, age: 18, name: "Bill")
    bill2 = insert(:user, age: 81, name: "Bill")
    bob = insert(:user, age: 40, name: "Bob")

    # Act
    users = User |> Plasm.where_all(name: "Bill") |> Repo.all

    # Assert
    assert Enum.member?(users, bill1)
    assert Enum.member?(users, bill2)
    refute Enum.member?(users, bob)
  end

  test ".where_all with two fields" do
    # Arrange
    bill1 = insert(:user, age: 18, name: "Bill")
    bill2 = insert(:user, age: 81, name: "Bill")
    bob = insert(:user, age: 40, name: "Bob")

    # Act
    users = User |> Plasm.where_all(name: "Bill", age: 18) |> Repo.all

    # Assert
    assert Enum.member?(users, bill1)
    refute Enum.member?(users, bill2)
    refute Enum.member?(users, bob)
  end
end
