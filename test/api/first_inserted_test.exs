defmodule Plasm.Api.FirstInsertedTest do
  use Plasm.ApiCase

  test ".first_inserted" do
    plasm_query_string =
      Plasm.User
      |> Plasm.first_inserted
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

  test ".first_inserted with an integer arg" do
    num_results = 15

    plasm_query_string =
      Plasm.User
      |> Plasm.first_inserted(num_results)
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
