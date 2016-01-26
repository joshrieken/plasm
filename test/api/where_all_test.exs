defmodule Plasm.Api.WhereAllTest do
  use Plasm.ApiCase

  test ".where_all with two fields" do
    plasm_query_string =
      Plasm.User
      |> Plasm.where_all(name: "Bill", age: 23)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.name == ^"Bill",
        where: u.age == ^23
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
