defmodule Plasm.OnOrLaterThanTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".on_or_later_than with an Ecto.DateTime" do
    # Arrange
    query_date = "2016-07-27"
    earlier_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-26T00:00:00Z"))
    exact_match_user = insert(:user, inserted_at: Ecto.DateTime.cast!(query_date <> "T00:00:00Z"))
    later_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-28T00:00:00Z"))

    # Act
    users = User |> Plasm.on_or_later_than(:inserted_at, Ecto.Date.cast!(query_date)) |> Repo.all

    # Assert
    assert Enum.member?(users, exact_match_user)
    assert Enum.member?(users, later_user)
    refute Enum.member?(users, earlier_user)
  end

  test ".on_or_later_than with a castable Ecto.DateTime" do
    # Arrange
    query_date = "2016-07-27"
    earlier_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-26T00:00:00Z"))
    exact_match_user = insert(:user, inserted_at: Ecto.DateTime.cast!(query_date <> "T00:00:00Z"))
    later_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-28T00:00:00Z"))

    # Act
    users = User |> Plasm.on_or_later_than(:inserted_at, query_date) |> Repo.all

    # Assert
    assert Enum.member?(users, later_user)
    assert Enum.member?(users, exact_match_user)
    refute Enum.member?(users, earlier_user)
  end
end
