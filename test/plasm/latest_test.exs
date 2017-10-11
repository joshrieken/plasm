defmodule Plasm.LatestTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".latest with an atom field name" do
    # Arrange
    insert(:user, inserted_at: "2016-07-26T00:00:00Z")
    insert(:user, inserted_at: "2016-07-27T00:00:00Z")
    latest_user = insert(:user, inserted_at: "2016-07-28T00:00:00Z")

    # Act
    user = User |> Plasm.latest(:inserted_at) |> Repo.one()

    # Assert
    assert user.id == latest_user.id
  end

  test ".latest with an atom field name and a count" do
    # Arrange
    earliest_user = insert(:user, inserted_at: "2016-07-26T00:00:00Z")
    later_user = insert(:user, inserted_at: "2016-07-27T00:00:00Z")
    latest_user = insert(:user, inserted_at: "2016-07-28T00:00:00Z")

    # Act
    user_ids = User |> Plasm.latest(:inserted_at, 2) |> Repo.all() |> Enum.map(&(&1.id))

    # Assert
    assert Enum.member?(user_ids, later_user.id)
    assert Enum.member?(user_ids, latest_user.id)
    refute Enum.member?(user_ids, earliest_user.id)
  end
end
