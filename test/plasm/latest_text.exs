defmodule Plasm.LatestTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".latest with an atom field name" do
    # Arrange
    query_date_time = Ecto.DateTime.cast!()
    insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-26T00:00:00Z"))
    insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-27T00:00:00Z"))
    latest_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-28T00:00:00Z"))

    # Act
    user = User |> Plasm.latest(:inserted_at) |> Repo.one

    # Assert
    assert user == latest_user
  end

  test ".latest with an atom field name and a count" do
    # Arrange
    earliest_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-26T00:00:00Z"))
    later_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-27T00:00:00Z"))
    latest_user = insert(:user, inserted_at: Ecto.DateTime.cast!("2016-07-28T00:00:00Z"))

    # Act
    users = User |> Plasm.latest(:inserted_at, 2) |> Repo.all

    # Assert
    assert Enum.member?(users, later_user)
    assert Enum.member?(users, latest_user)
    refute Enum.member?(users, earliest_user)
  end
end
