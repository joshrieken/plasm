defmodule Plasm.Api.MaxTest do
  use Plasm.ApiCase

  test ".max" do
    plasm_query_string =
      Plasm.User
      |> Plasm.max(:age)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        select: max(u.age)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
