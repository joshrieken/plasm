defmodule Plasm.EarliestTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".earliest with an atom field name" do
    # Arrange
    earliest_user = insert(:user, inserted_at: "2016-07-26T00:00:00Z")
    insert(:user, inserted_at: "2016-07-27T00:00:00Z")
    insert(:user, inserted_at: "2016-07-28T00:00:00Z")

    # Act
    user = User |> Plasm.earliest(:inserted_at) |> Repo.one()

    # Assert
    assert user.id == earliest_user.id
  end

  test ".earliest with an atom field name and a count" do
    # Arrange
    earliest_user = insert(:user, inserted_at: "2016-07-26T00:00:00Z")
    later_user = insert(:user, inserted_at: "2016-07-27T00:00:00Z")
    latest_user = insert(:user, inserted_at: "2016-07-28T00:00:00Z")

    # Act
    user_ids = User |> Plasm.earliest(:inserted_at, 2) |> Repo.all() |> Enum.map(&(&1.id))

    # Assert
    assert Enum.member?(user_ids, earliest_user.id)
    assert Enum.member?(user_ids, later_user.id)
    refute Enum.member?(user_ids, latest_user.id)
  end
end
