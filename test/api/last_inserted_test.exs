defmodule Plasm.Api.LastInsertedTest do
  use Plasm.ApiCase

  test ".last_inserted" do
    plasm_query_string =
      Plasm.User
      |> Plasm.last_inserted
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        order_by: [desc: u.inserted_at],
        limit: ^1
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".last_inserted with an integer arg" do
    num_results = 15

    plasm_query_string =
      Plasm.User
      |> Plasm.last_inserted(num_results)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        order_by: [desc: u.inserted_at],
        limit: ^num_results
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
