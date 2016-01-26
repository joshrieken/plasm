defmodule Plasm.Api.WhereAllTest do
  use Plasm.ApiCase

  test ".where_all with two fields" do
    name = "Bill"
    age = 23

    plasm_query_string =
      Plasm.User
      |> Plasm.where_all(name: name, age: age)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.name == ^name and u.age == ^age
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".where_all with two fields and one is a list" do
    name = "Bill"
    ages = [21,22,23]

    plasm_query_string =
      Plasm.User
      |> Plasm.where_all(name: name, age: ages)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.name == ^name,
        where: u.age in ^ages
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
