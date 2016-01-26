defmodule Plasm.Api.ForValuesNotTest do
  use Plasm.ApiCase

  test ".for_values_not with a binary field name" do
    field_name = "name"
    atom_field_name = String.to_atom(field_name)
    field_values = ["Mulder", "Scully"]

    plasm_query_string =
      Plasm.User
      |> Plasm.for_values_not(field_name, field_values)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: not field(u, ^atom_field_name) in ^field_values
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".for_values_not with an atom field name" do
    field_name = :name
    field_values = ["Mulder", "Scully"]

    plasm_query_string =
      Plasm.User
      |> Plasm.for_values_not(field_name, field_values)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: not field(u, ^field_name) in ^field_values
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
