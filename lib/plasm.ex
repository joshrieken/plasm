defmodule Plasm do
  import Ecto.Query

  def avg(query, field_name) do
    query
    |> select([x], avg(field(x, ^field_name)))
  end

  def count(query) do
    query
    |> exclude_exclusive_fields_for_count
    |> select([x], count(x.id))
  end

  def count_distinct(query, field_name) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> count_distinct(field_name)
  end
  def count_distinct(query, field_name) when is_atom(field_name) do
    query
    |> exclude_exclusive_fields_for_count
    |> select([x], count(field(x, ^field_name), :distinct))
  end

  def distinct_by(query, field_name) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> distinct_by(field_name)
  end
  def distinct_by(query, field_name) when is_atom(field_name) do
    query
    |> distinct([x], field(x, ^field_name))
  end

  def find(query, ids) when is_list(ids) do
    key = primary_key(query)

    query
    |> for_values(key, ids)
  end

  def find(query, id) do
    key = primary_key(query)

    query
    |> for_value(key, id)
  end

  def first(query) do
    query
    |> first(1)
  end
  def first(query, n) do
    query
    |> exclude_all_exclusive_fields
    |> order_by(asc: :inserted_at)
    |> limit(^n)
  end

  def for_value(query, field_name, field_value) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> for_value(field_name, field_value)
  end
  def for_value(query, field_name, field_value) when is_atom(field_name) do
    query
    |> where([x], field(x, ^field_name) == ^field_value)
  end

  def for_value_not(query, field_name, field_value) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> for_value_not(field_name, field_value)
  end
  def for_value_not(query, field_name, field_value) when is_atom(field_name) do
    query
    |> where([x], field(x, ^field_name) != ^field_value)
  end

  def for_values(query, field_name, field_values) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> for_values(field_name, field_values)
  end
  def for_values(query, field_name, field_values) when is_atom(field_name) do
    query
    |> where([x], field(x, ^field_name) in ^field_values)
  end

  def for_values_not(query, field_name, field_values) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> for_values_not(field_name, field_values)
  end
  def for_values_not(query, field_name, field_values) when is_atom(field_name) do
    query
    |> where([x], not field(x, ^field_name) in ^field_values)
  end

  def inserted_after(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.inserted_at > ^ecto_date_time)
  end
  def inserted_after(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> inserted_after(ecto_date_time)
  end

  def inserted_after_incl(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.inserted_at >= ^ecto_date_time)
  end
  def inserted_after_incl(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> inserted_after_incl(ecto_date_time)
  end

  def inserted_before(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.inserted_at < ^ecto_date_time)
  end
  def inserted_before(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> inserted_before(ecto_date_time)
  end

  def inserted_before_incl(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.inserted_at <= ^ecto_date_time)
  end
  def inserted_before_incl(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> inserted_before_incl(ecto_date_time)
  end

  def last(query) do
    query
    |> last(1)
  end
  def last(query, n) do
    query
    |> exclude_all_exclusive_fields
    |> order_by(desc: :inserted_at)
    |> limit(^n)
  end

  def max(query, field_name) do
    query
    |> select([x], max(field(x, ^field_name)))
  end

  def min(query, field_name) do
    query
    |> select([x], min(field(x, ^field_name)))
  end

  def random(query) do
    query
    |> random(1)
  end
  def random(query, n) do
    # TODO: support databases other than postgres
    query
    |> order_by([_], fragment("RANDOM()"))
    |> limit(^n)
  end

  def sum(query, field_name) do
    query
    |> select([x], sum(field(x, ^field_name)))
  end

  def updated_after(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.updated_at > ^ecto_date_time)
  end
  def updated_after(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> updated_after(ecto_date_time)
  end

  def updated_after_incl(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.updated_at >= ^ecto_date_time)
  end
  def updated_after_incl(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> updated_after_incl(ecto_date_time)
  end

  def updated_before(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.updated_at < ^ecto_date_time)
  end
  def updated_before(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> updated_before(ecto_date_time)
  end

  def updated_before_incl(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.updated_at <= ^ecto_date_time)
  end
  def updated_before_incl(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> updated_before_incl(ecto_date_time)
  end

  def where_all(query, field_names_and_values) when is_list(field_names_and_values) do
    Enum.reduce(field_names_and_values, query, fn ({field_name, field_value}, query) ->
      generate_where_clause_for_where_all(query, field_name, field_value)
    end)
  end

  def where_none(query, field_names_and_values) do
    Enum.reduce(field_names_and_values, query, fn ({field_name, field_value}, query) ->
      generate_where_clause_for_where_none(query, field_name, field_value)
    end)
  end

  # PRIVATE ######################################

  defp exclude_exclusive_fields_for_count(query) do
    query
    |> exclude_all_exclusive_fields
  end

  defp exclude_all_exclusive_fields(query) do
    query
    |> exclude(:order_by)
    |> exclude(:preload)
    |> exclude(:select)
  end

  defp primary_key(query) do
    [key] = model(query).__schema__(:primary_key)
    key
  end

  def model(%Ecto.Query{from: {_table_name, model_or_query}}) do
    model(model_or_query)
  end
  def model(model), do: model

  def generate_where_clause_for_where_all(query, field_name, field_value) when is_list(field_value) do
    query
    |> where([x], field(x, ^field_name) in ^field_value)
  end
  def generate_where_clause_for_where_all(query, field_name, field_value) do
    query
    |> where([x], field(x, ^field_name) == ^field_value)
  end

  def generate_where_clause_for_where_none(query, field_name, field_value) when is_list(field_value) do
    query
    |> where([x], not field(x, ^field_name) in ^field_value)
  end
  def generate_where_clause_for_where_none(query, field_name, field_value) do
    query
    |> where([x], field(x, ^field_name) != ^field_value)
  end
end
