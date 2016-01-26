defmodule Plasm.Api.CountDistinctTest do
  use Plasm.ApiCase

  test ".count_distinct with a binary arg" do
    plasm_query_string =
      Plasm.User
      |> Plasm.count_distinct("id")
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        select: count(u.id, :distinct)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".count_distinct with an atom arg" do
    plasm_query_string =
      Plasm.User
      |> Plasm.count_distinct(:id)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        select: count(u.id, :distinct)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
