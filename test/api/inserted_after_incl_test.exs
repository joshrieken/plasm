defmodule Plasm.Api.InsertedAfterInclTest do
  use Plasm.ApiCase

  test ".inserted_after_incl with an Ecto.DateTime" do
    ecto_datetime = Ecto.DateTime.utc

    plasm_query_string =
      Plasm.User
      |> Plasm.inserted_after_incl(ecto_datetime)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.inserted_at >= ^ecto_datetime
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".inserted_after_incl with a castable Ecto.DateTime" do
    castable_ecto_datetime = "2014-04-17T14:00:00Z"
    {:ok, ecto_datetime} = Ecto.DateTime.cast(castable_ecto_datetime)

    plasm_query_string =
      Plasm.User
      |> Plasm.inserted_after_incl(castable_ecto_datetime)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.inserted_at >= ^ecto_datetime
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
