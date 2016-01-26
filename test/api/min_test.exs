defmodule Plasm.Api.MinTest do
  use Plasm.ApiCase

  test ".min" do
    plasm_query_string =
      Plasm.User
      |> Plasm.min(:age)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        select: min(u.age)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
