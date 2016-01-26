defmodule Plasm.Api.DistinctByTest do
  use Plasm.ApiCase

  test ".distinct_by with a binary arg" do
    field_name = "name"
    atom_field_name = String.to_atom(field_name)

    plasm_query_string =
      Plasm.User
      |> Plasm.distinct_by(field_name)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        distinct: field(u, ^atom_field_name)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".distinct_by with an atom arg" do
    field_name = :name

    plasm_query_string =
      Plasm.User
      |> Plasm.distinct_by(field_name)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        distinct: field(u, ^field_name)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
