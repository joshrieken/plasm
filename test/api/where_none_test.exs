defmodule Plasm.Api.WhereNoneTest do
  use Plasm.ApiCase

  test ".where_none with two fields" do
    name = "Bill"
    age = 23

    plasm_query_string =
      Plasm.User
      |> Plasm.where_none(name: name, age: age)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.name != ^name,
        where: u.age != ^age
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".where_none with two fields and one is a list" do
    name = "Bill"
    ages = [23,24,25]

    plasm_query_string =
      Plasm.User
      |> Plasm.where_none(name: name, age: ages)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.name != ^name,
        where: not u.age in ^ages
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
