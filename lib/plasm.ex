defmodule Plasm do
  import Ecto.Query

  def count(query) do
    query
    |> exclude_count_jammers
    |> select([x], count(x.id))
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
    |> for_values(:id, ids)
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
    |> last(1)
  end
  def last(query, n) do
    query
    |> exclude_jammers
    |> order_by_desc(:inserted_at)
    |> limit(^n)
  end

  def order_by_asc(query, field_name) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> order_by_asc(field_name)
  end
  def order_by_asc(query, field_name) when is_atom(field_name) do
    query
    |> order_by([x], asc: field(x, ^field_name))
  end

  def order_by_desc(query, field_name) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> order_by_desc(field_name)
  end
  def order_by_desc(query, field_name) when is_atom(field_name) do
    query
    |> order_by([x], desc: field(x, ^field_name))
  end

  def random(query) do
    query
    |> random(1)
  end
  def random(query, n) do
    # env = Application.get_env(:plasm, Plasm.Repo)
    # random_fragment = case env[:adapter] do
    #   Ecto.Adapters.Postgres -> "RANDOM()"
    #   Ecto.Adapters.MySQL -> "RAND()"
    # end

    query
    |> order_by([_], fragment("RANDOM()"))
    |> limit(^n)
  end

  def take(query, n) do
    query
    |> limit(^n)
  end

  def uniq(query, field_name) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> uniq(field_name)
  end
  def uniq(query, field_name) when is_atom(field_name) do
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
