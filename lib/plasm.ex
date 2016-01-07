defmodule Plasm do
  import Ecto.Query

  def count(query) do
    query
    |> exclude_count_jammers
    |> select([x], count("*"))
  end

  def count_distinct(query, field_name) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> count_distinct(field_name)
  end
  def count_distinct(query, field_name) when is_atom(field_name) do
    query
    |> exclude_count_jammers
    |> select([x], count(field(x, ^field_name), :distinct))
  end

  def first(query) do
    query
    |> first(1)
  end
  def first(query, n) do
    query
    |> exclude_jammers
    |> order_by_asc(:inserted_at)
    |> limit(^n)
  end

  def for_id(query, id) do
    query
    |> for_value(:id, id)
  end

  def for_ids(query, ids) do
    query
    |> for_value_in_list(:id, ids)
  end

  def for_value(query, field_name, field_value) do
    query
    |> where([x], field(x, ^field_name) == ^field_value)
  end

  def for_value_in_list(query, field_name, value_list) do
    query
    |> where([x], field(x, ^field_name) in ^value_list)
  end

  def for_value_not_in_list(query, field_name, value_list) do
    query
    |> where([x], not field(x, ^field_name) in ^value_list)
  end

  def inserted_after(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> where([x], x.inserted_at > ^ecto_date_time)
  end

  def inserted_after_incl(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> where([x], x.inserted_at >= ^ecto_date_time)
  end

  def inserted_before(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> where([x], x.inserted_at < ^ecto_date_time)
  end

  def inserted_before_incl(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> where([x], x.inserted_at <= ^ecto_date_time)
  end

  def last(query) do
    query
    |> exclude_jammers
    |> order_by_desc(:inserted_at)
    |> limit(1)
  end

  def order_by_asc(query, field_name) do
    query
    |> order_by([x], asc: field(x, ^field_name))
  end

  def random(query) do
    query
    |> order_by([_], fragment("random()"))
    |> limit(1)
  end

  def order_by_desc(query, field_name) do
    query
    |> order_by([x], desc: field(x, ^field_name))
  end

  def take(query, n) do
    query
    |> limit(^n)
  end

  def uniq(query, field_name) when is_boolean(field_name) do
    query
    |> distinct([_], ^field_name)
  end
  def uniq(query, field_name) do
    query
    |> distinct([x], field(x, ^field_name))
  end

  def updated_after(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> where([x], x.updated_at > ^ecto_date_time)
  end

  def updated_after_incl(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> where([x], x.updated_at >= ^ecto_date_time)
  end

  def updated_before(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> where([x], x.updated_at < ^ecto_date_time)
  end

  def updated_before_incl(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> where([x], x.updated_at <= ^ecto_date_time)
  end

  # PRIVATE ######################################

  defp exclude_count_jammers(query) do
    query
    |> exclude_jammers
  end

  defp exclude_jammers(query) do
    query
    |> exclude(:order_by)
    |> exclude(:preload)
    |> exclude(:select)
  end
end
