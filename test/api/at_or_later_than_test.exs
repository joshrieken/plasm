defmodule Plasm.Api.AtOrLaterThanTest do
  use Plasm.ApiCase

  test ".at_or_later_than with an Ecto.DateTime" do
    ecto_date_time = Ecto.DateTime.utc
    field_name = :updated_at

    plasm_query_string =
      Plasm.User
      |> Plasm.at_or_later_than(field_name, ecto_date_time)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: field(u, ^field_name) >= type(^ecto_date_time, Ecto.DateTime)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".at_or_later_than with a castable Ecto.DateTime" do
    castable = "2014-09-09T14:00:00Z"
    ecto_date_time = Ecto.DateTime.cast!(castable)
    field_name = :updated_at

    plasm_query_string =
      Plasm.User
      |> Plasm.at_or_later_than(field_name, castable)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: field(u, ^field_name) >= type(^ecto_date_time, Ecto.DateTime)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
