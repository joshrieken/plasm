defmodule Plasm.Api.CountTest do
  use Plasm.ApiCase

  test ".count" do
    plasm_query_string =
      Plasm.User
      |> Plasm.count
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        select: count(u.id)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
