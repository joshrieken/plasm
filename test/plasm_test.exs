defmodule PlasmTest do
  use ExUnit.Case
  require Ecto.Query

  doctest Plasm

  setup do
    Ecto.Adapters.SQL.begin_test_transaction(Plasm.Repo)

    ExUnit.Callbacks.on_exit fn ->
      Ecto.Adapters.SQL.rollback_test_transaction(Plasm.Repo)
    end
  end

  test ".count" do
    plasm_query_string =
      Plasm.User
      |> Plasm.count
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        select: count(u.id)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".count_distinct with a binary arg" do
    plasm_query_string =
      Plasm.User
      |> Plasm.count_distinct("id")
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        select: count(u.id, :distinct)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".count_distinct with an atom arg" do
    plasm_query_string =
      Plasm.User
      |> Plasm.count_distinct(:id)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        select: count(u.id, :distinct)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".first" do
    plasm_query_string =
      Plasm.User
      |> Plasm.first
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        order_by: [asc: u.inserted_at],
        limit: ^1
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".first with an integer arg" do
    num_results = 15

    plasm_query_string =
      Plasm.User
      |> Plasm.first(num_results)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        order_by: [asc: u.inserted_at],
        limit: ^num_results
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".for_id" do
    id = 4

    plasm_query_string =
      Plasm.User
      |> Plasm.for_id(id)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.id == ^id
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".for_ids" do
    ids = [4,5,6]

    plasm_query_string =
      Plasm.User
      |> Plasm.for_ids(ids)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.id in ^ids
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".for_value with a binary field name" do
    field_name = "name"
    atom_field_name = String.to_atom(field_name)
    field_value = "Herbaliser"

    plasm_query_string =
      Plasm.User
      |> Plasm.for_value(field_name, field_value)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: field(u, ^atom_field_name) == ^field_value
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".for_value with an atom field name" do
    field_name = :name
    field_value = "Herbaliser"

    plasm_query_string =
      Plasm.User
      |> Plasm.for_value(field_name, field_value)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: field(u, ^field_name) == ^field_value
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".for_values with a binary field name" do
    field_name = "name"
    atom_field_name = String.to_atom(field_name)
    field_values = ["Yakko", "Wakko", "Dot"]

    plasm_query_string =
      Plasm.User
      |> Plasm.for_values(field_name, field_values)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: field(u, ^atom_field_name) in ^field_values
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".for_values with an atom field name" do
    field_name = :name
    field_values = ["Yakko", "Wakko", "Dot"]

    plasm_query_string =
      Plasm.User
      |> Plasm.for_values(field_name, field_values)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: field(u, ^field_name) in ^field_values
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".for_value_not with a binary field name" do
    field_name = "name"
    atom_field_name = String.to_atom(field_name)
    field_value = "Mulder"

    plasm_query_string =
      Plasm.User
      |> Plasm.for_value_not(field_name, field_value)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: field(u, ^atom_field_name) != ^field_value
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".for_value_not with an atom field name" do
    field_name = :name
    field_value = "Mulder"

    plasm_query_string =
      Plasm.User
      |> Plasm.for_value_not(field_name, field_value)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: field(u, ^field_name) != ^field_value
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

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

  test ".inserted_after with a castable Ecto.DateTime" do
    castable_ecto_datetime = "2014-04-17T14:00:00Z"
    {:ok, ecto_datetime} = Ecto.DateTime.cast(castable_ecto_datetime)

    plasm_query_string =
      Plasm.User
      |> Plasm.inserted_after(castable_ecto_datetime)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.inserted_at > ^ecto_datetime
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".inserted_after_incl with a castable Ecto.DateTime" do
    castable_ecto_datetime = "2014-04-17T14:00:00Z"
    {:ok, ecto_datetime} = Ecto.DateTime.cast(castable_ecto_datetime)

    plasm_query_string =
      Plasm.User
      |> Plasm.inserted_after_incl(castable_ecto_datetime)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.inserted_at >= ^ecto_datetime
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".inserted_before with a castable Ecto.DateTime" do
    castable_ecto_datetime = "2014-04-17T14:00:00Z"
    {:ok, ecto_datetime} = Ecto.DateTime.cast(castable_ecto_datetime)

    plasm_query_string =
      Plasm.User
      |> Plasm.inserted_before(castable_ecto_datetime)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.inserted_at < ^ecto_datetime
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".inserted_before_incl with a castable Ecto.DateTime" do
    castable_ecto_datetime = "2014-04-17T14:00:00Z"
    {:ok, ecto_datetime} = Ecto.DateTime.cast(castable_ecto_datetime)

    plasm_query_string =
      Plasm.User
      |> Plasm.inserted_before_incl(castable_ecto_datetime)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.inserted_at <= ^ecto_datetime
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".last" do
    plasm_query_string =
      Plasm.User
      |> Plasm.last
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

  test ".last with an integer arg" do
    num_results = 15

    plasm_query_string =
      Plasm.User
      |> Plasm.last(num_results)
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

  test ".order_by_asc with a binary arg" do
    field_name = "name"
    atom_field_name = String.to_atom(field_name)

    plasm_query_string =
      Plasm.User
      |> Plasm.order_by_asc(field_name)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        order_by: [asc: field(u, ^atom_field_name)]
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".order_by_asc with an atom arg" do
    field_name = :name

    plasm_query_string =
      Plasm.User
      |> Plasm.order_by_asc(field_name)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        order_by: [asc: field(u, ^field_name)]
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".order_by_desc with a binary arg" do
    field_name = "name"
    atom_field_name = String.to_atom(field_name)

    plasm_query_string =
      Plasm.User
      |> Plasm.order_by_desc(field_name)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        order_by: [desc: field(u, ^atom_field_name)]
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".order_by_desc with an atom arg" do
    field_name = :name

    plasm_query_string =
      Plasm.User
      |> Plasm.order_by_desc(field_name)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        order_by: [desc: field(u, ^field_name)]
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  # test ".random for PostgreSQL" do
  #   plasm_query_string =
  #     Plasm.User
  #     |> Plasm.random
  #     |> query_to_string

  #   ecto_query_string =
  #     Ecto.Query.from(
  #       u in Plasm.User,
  #       order_by: fragment("RANDOM()"),
  #       limit: 1
  #     )
  #     |> query_to_string

  #   assert plasm_query_string == ecto_query_string
  # end

  test ".take" do
    num_to_take = 10

    plasm_query_string =
      Plasm.User
      |> Plasm.take(num_to_take)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        limit: ^num_to_take
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".uniq with a binary arg" do
    field_name = "name"
    atom_field_name = String.to_atom(field_name)

    plasm_query_string =
      Plasm.User
      |> Plasm.uniq(field_name)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        distinct: field(u, ^atom_field_name)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".uniq with an atom arg" do
    field_name = :name

    plasm_query_string =
      Plasm.User
      |> Plasm.uniq(field_name)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        distinct: field(u, ^field_name)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".updated_after with a castable Ecto.DateTime" do
    castable_ecto_datetime = "2014-04-17T14:00:00Z"
    {:ok, ecto_datetime} = Ecto.DateTime.cast(castable_ecto_datetime)

    plasm_query_string =
      Plasm.User
      |> Plasm.updated_after(castable_ecto_datetime)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.updated_at > ^ecto_datetime
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".updated_after_incl with a castable Ecto.DateTime" do
    castable_ecto_datetime = "2014-04-17T14:00:00Z"
    {:ok, ecto_datetime} = Ecto.DateTime.cast(castable_ecto_datetime)

    plasm_query_string =
      Plasm.User
      |> Plasm.updated_after_incl(castable_ecto_datetime)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.updated_at >= ^ecto_datetime
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".updated_before with a castable Ecto.DateTime" do
    castable_ecto_datetime = "2014-04-17T14:00:00Z"
    {:ok, ecto_datetime} = Ecto.DateTime.cast(castable_ecto_datetime)

    plasm_query_string =
      Plasm.User
      |> Plasm.updated_before(castable_ecto_datetime)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.updated_at < ^ecto_datetime
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".updated_before_incl with a castable Ecto.DateTime" do
    castable_ecto_datetime = "2014-04-17T14:00:00Z"
    {:ok, ecto_datetime} = Ecto.DateTime.cast(castable_ecto_datetime)

    plasm_query_string =
      Plasm.User
      |> Plasm.updated_before_incl(castable_ecto_datetime)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.updated_at <= ^ecto_datetime
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end


  # PRIVATE ##################

  defp query_to_string(query) do
    Inspect.Ecto.Query.to_string(query)
  end
end
