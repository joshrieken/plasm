defmodule Plasm.OnTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".on with an Ecto.Date" do
    # Arrange
    query_date = "2016-07-27"
    earlier_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-26T00:00:00Z"))
    exact_match_user = insert(:user, inserted_at: Ecto.DateTime.cast!(query_date <> "T14:00:00Z"))
    later_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-28T00:00:00Z"))

    # Act
    users = User |> Plasm.on(:inserted_at, Ecto.Date.cast!(query_date)) |> Repo.all

    # Assert
    assert Enum.member?(users, exact_match_user)
    refute Enum.member?(users, later_user)
    refute Enum.member?(users, earlier_user)
  end

  test ".on with a castable Ecto.Date" do
    # Arrange
    query_date = "2016-07-27"
    earlier_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-26T00:00:00Z"))
    exact_match_user = insert(:user, inserted_at: Ecto.DateTime.cast!(query_date <> "T00:00:00Z"))
    later_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-28T00:00:00Z"))

    # Act
    users = User |> Plasm.on(:inserted_at, query_date) |> Repo.all

    # Assert
    assert Enum.member?(users, exact_match_user)
    refute Enum.member?(users, later_user)
    refute Enum.member?(users, earlier_user)
  end
end
