defmodule Plasm.Api.FindTest do
  use Plasm.ApiCase

  test ".find with a list arg" do
    ids = [4,5,6,7,8]

    plasm_query_string =
      Plasm.User
      |> Plasm.find(ids)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.id in ^ids
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".find with a non-list arg" do
    id = 4

    plasm_query_string =
      Plasm.User
      |> Plasm.find(id)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.id == ^id
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
