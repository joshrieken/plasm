defmodule Plasm.AtTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".at with an Ecto.DateTime" do
    # Arrange
    query_date_time = Ecto.DateTime.cast!("2016-07-27T00:00:00Z")
    earlier_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-26T00:00:00Z"))
    exact_match_user = insert(:user, inserted_at: Ecto.DateTime.cast!(query_date_time))
    later_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-28T00:00:00Z"))

    # Act
    users = User |> Plasm.at(:inserted_at, query_date_time) |> Repo.all

    # Assert
    assert Enum.member?(users, exact_match_user)
    refute Enum.member?(users, later_user)
    refute Enum.member?(users, earlier_user)
  end

  test ".at with a castable Ecto.DateTime" do
    # Arrange
    castable_string = "2016-07-27T00:00:00Z"
    earlier_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-26T00:00:00Z"))
    exact_match_user = insert(:user, inserted_at: Ecto.DateTime.cast!(castable_string))
    later_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-28T00:00:00Z"))

    # Act
    users = User |> Plasm.at(:inserted_at, castable_string) |> Repo.all

    # Assert
    assert Enum.member?(users, exact_match_user)
    refute Enum.member?(users, later_user)
    refute Enum.member?(users, earlier_user)
  end
end
