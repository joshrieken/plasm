defmodule Plasm.Api.InsertedAfterTest do
  use Plasm.ApiCase

  test ".inserted_after with an Ecto.DateTime" do
    ecto_datetime = Ecto.DateTime.utc

    plasm_query_string =
      Plasm.User
      |> Plasm.inserted_after(ecto_datetime)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.inserted_at > ^ecto_datetime
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".inserted_after with a castable Ecto.DateTime" do
    castable_ecto_datetime = "2014-04-17T14:00:00Z"
    {:ok, ecto_datetime} = Ecto.DateTime.cast(castable_ecto_datetime)

    plasm_query_string =
      Plasm.User
      |> Plasm.inserted_after(castable_ecto_datetime)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.inserted_at > ^ecto_datetime
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
