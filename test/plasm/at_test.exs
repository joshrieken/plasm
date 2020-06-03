defmodule Plasm.AtTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".at with a DateTime" do
    # Arrange
    castable_string = "2016-07-27T00:00:00Z"
    {:ok, date_time, _} = DateTime.from_iso8601(castable_string)
    earlier_user = insert(:user, inserted_at: "2016-07-26T00:00:00Z")
    exact_match_user = insert(:user, inserted_at: castable_string)
    later_user = insert(:user, inserted_at: "2016-07-28T00:00:00Z")

    # Act
    user_ids = User |> Plasm.at(:inserted_at, date_time) |> Repo.all() |> Enum.map(&(&1.id))

    # Assert
    assert Enum.member?(user_ids, exact_match_user.id)
    refute Enum.member?(user_ids, later_user.id)
    refute Enum.member?(user_ids, earlier_user.id)
  end

  test ".at with a castable date time string" do
    # Arrange
    castable_string = "2016-07-27T00:00:00Z"
    earlier_user = insert(:user, inserted_at: "2016-07-26T00:00:00Z")
    exact_match_user = insert(:user, inserted_at: castable_string)
    later_user = insert(:user, inserted_at: "2016-07-28T00:00:00Z")

    # Act
    user_ids = User |> Plasm.at(:inserted_at, castable_string) |> Repo.all() |> Enum.map(&(&1.id))

    # Assert
    assert Enum.member?(user_ids, exact_match_user.id)
    refute Enum.member?(user_ids, later_user.id)
    refute Enum.member?(user_ids, earlier_user.id)
  end
end
