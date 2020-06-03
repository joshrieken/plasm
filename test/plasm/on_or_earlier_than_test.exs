defmodule Plasm.OnOrEarlierThanTest do
  use Plasm.Case

  alias Plasm.Repo
  alias Plasm.User

  import Plasm.Factory

  test ".on_or_earlier_than with a Date when the field is a date" do
    # Arrange
    castable_string = "1980-01-02"
    {:ok, date_of_birth} = Date.from_iso8601(castable_string)
    earlier_user = insert(:user, date_of_birth: ~D[1979-08-16])
    exact_match_user = insert(:user, date_of_birth: date_of_birth)
    later_user = insert(:user, date_of_birth: ~D[1990-02-03])

    # Act
    user_ids = User |> Plasm.on_or_earlier_than(:date_of_birth, date_of_birth) |> Repo.all() |> Enum.map(&(&1.id))

    # Assert
    assert Enum.member?(user_ids, earlier_user.id)
    assert Enum.member?(user_ids, exact_match_user.id)
    refute Enum.member?(user_ids, later_user.id)
  end

  test ".on_or_earlier_than with a castable date string when the field is a date" do
    # Arrange
    castable_string = "1980-01-02"
    {:ok, date_of_birth} = Date.from_iso8601(castable_string)
    earlier_user = insert(:user, date_of_birth: ~D[1979-08-16])
    exact_match_user = insert(:user, date_of_birth: date_of_birth)
    later_user = insert(:user, date_of_birth: ~D[1990-02-03])

    # Act
    user_ids = User |> Plasm.on_or_earlier_than(:date_of_birth, castable_string) |> Repo.all() |> Enum.map(&(&1.id))

    # Assert
    assert Enum.member?(user_ids, earlier_user.id)
    assert Enum.member?(user_ids, exact_match_user.id)
    refute Enum.member?(user_ids, later_user.id)
  end

  test ".on_or_earlier_than with a Date when the field is a date time" do
    # Arrange
    castable_string = "2016-07-27"
    {:ok, inserted_at_date} = Date.from_iso8601(castable_string)
    earlier_user = insert(:user, inserted_at: "2016-07-26T00:00:00Z")
    exact_match_user = insert(:user, inserted_at: castable_string <> "T00:00:00Z")
    later_user = insert(:user, inserted_at: "2016-07-28T00:00:00Z")

    # Act
    user_ids = User |> Plasm.on_or_earlier_than(:inserted_at, inserted_at_date) |> Repo.all() |> Enum.map(&(&1.id))

    # Assert
    assert Enum.member?(user_ids, earlier_user.id)
    assert Enum.member?(user_ids, exact_match_user.id)
    refute Enum.member?(user_ids, later_user.id)
  end

  test ".on_or_earlier_than with a castable date string when the field is a date time" do
    # Arrange
    castable_string = "2016-07-27"
    earlier_user = insert(:user, inserted_at: "2016-07-26T00:00:00Z")
    exact_match_user = insert(:user, inserted_at: castable_string <> "T00:00:00Z")
    later_user = insert(:user, inserted_at: "2016-07-28T00:00:00Z")

    # Act
    user_ids = User |> Plasm.on_or_earlier_than(:inserted_at, castable_string) |> Repo.all() |> Enum.map(&(&1.id))

    # Assert
    assert Enum.member?(user_ids, earlier_user.id)
    assert Enum.member?(user_ids, exact_match_user.id)
    refute Enum.member?(user_ids, later_user.id)
  end
end
