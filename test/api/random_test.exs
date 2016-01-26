defmodule Plasm.Api.RandomTest do
  use Plasm.ApiCase

  test ".random for PostgreSQL" do
    plasm_query_string =
      Plasm.User
      |> Plasm.random
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        order_by: fragment("RANDOM()"),
        limit: ^1
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
