defmodule Plasm.EarliestTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".earliest with an atom field name" do
    # Arrange
    earliest_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-26T00:00:00Z"))
    insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-27T00:00:00Z"))
    insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-28T00:00:00Z"))

    # Act
    user = User |> Plasm.earliest(:inserted_at) |> Repo.one

    # Assert
    assert user == earliest_user
  end

  test ".earliest with an atom field name and a count" do
    # Arrange
    earliest_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-26T00:00:00Z"))
    later_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-27T00:00:00Z"))
    latest_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-28T00:00:00Z"))

    # Act
    users = User |> Plasm.earliest(:inserted_at, 2) |> Repo.all

    # Assert
    assert Enum.member?(users, earliest_user)
    assert Enum.member?(users, later_user)
    refute Enum.member?(users, latest_user)
  end
end
