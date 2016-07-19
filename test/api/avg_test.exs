defmodule Plasm.Api.AvgTest do
  use Plasm.ApiCase

  test ".avg with an atom field name" do
    plasm_query_string =
      Plasm.User
      |> Plasm.avg(:age)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        select: avg(u.age)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".avg with a String.t field name" do
    plasm_query_string =
      Plasm.User
      |> Plasm.avg("age")
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        select: avg(u.age)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
