defmodule Plasm.Api.FirstTest do
  use Plasm.ApiCase

  test ".first" do
    plasm_query_string =
      Plasm.User
      |> Plasm.first
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        order_by: [asc: u.inserted_at],
        limit: ^1
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".first with an integer arg" do
    num_results = 15

    plasm_query_string =
      Plasm.User
      |> Plasm.first(num_results)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        order_by: [asc: u.inserted_at],
        limit: ^num_results
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
