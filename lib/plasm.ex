defmodule Plasm do
  import Ecto.Query

  @doc """
  Builds a query that finds all records at a specified date and time for a specified field name.

      Puppy |> Plasm.at(:updated_at, ecto_date_time) |> Repo.all

      Puppy |> Plasm.at(:updated_at, "2014-04-17T14:00:00Z") |> Repo.all
  """
  @spec at(Ecto.Queryable, atom, %Ecto.DateTime{}) :: Ecto.Queryable
  def at(query, field_name, %Ecto.DateTime{} = ecto_date_time) when is_atom(field_name) do
    query
    |> where([x], field(x, ^field_name) == type(^ecto_date_time, Ecto.DateTime))
  end
  @spec at(Ecto.Queryable, atom, any) :: Ecto.Queryable
  def at(query, field_name, castable) when is_atom(field_name) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> at(field_name, ecto_date_time)
  end

  @doc """
  Builds a query that finds all records at a specified date and time for a specified field name.

      Puppy |> Plasm.at_or_later_than(:updated_at, ecto_date_time) |> Repo.all

      Puppy |> Plasm.at_or_later_than(:updated_at, "2014-04-17") |> Repo.all
  """
  @spec at_or_later_than(Ecto.Queryable, atom, %Ecto.DateTime{}) :: Ecto.Queryable
  def at_or_later_than(query, field_name, %Ecto.DateTime{} = ecto_date_time) when is_atom(field_name) do
    query
    |> where([x], field(x, ^field_name) >= type(^ecto_date_time, Ecto.DateTime))
  end
  @spec at_or_later_than(Ecto.Queryable, atom, any) :: Ecto.Queryable
  def at_or_later_than(query, field_name, castable) when is_atom(field_name) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> at_or_later_than(field_name, ecto_date_time)
  end

  @doc """
  Builds a query that finds all records at or before a specified date and time for a specified field name.

      Puppy |> Plasm.at_or_earlier_than(:updated_at, ecto_date_time) |> Repo.all

      Puppy |> Plasm.at_or_earlier_than(:updated_at, "2014-04-17") |> Repo.all
  """
  @spec at_or_earlier_than(Ecto.Queryable, atom, %Ecto.DateTime{}) :: Ecto.Queryable
  def at_or_earlier_than(query, field_name, %Ecto.DateTime{} = ecto_date_time) when is_atom(field_name) do
    query
    |> where([x], field(x, ^field_name) <= type(^ecto_date_time, Ecto.DateTime))
  end
  @spec at_or_earlier_than(Ecto.Queryable, atom, any) :: Ecto.Queryable
  def at_or_earlier_than(query, field_name, castable) when is_atom(field_name) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> at_or_earlier_than(field_name, ecto_date_time)
  end

  @doc """
  Builds an avg query for a given field.

      Puppy |> Plasm.avg(:age) |> Repo.one

      Puppy |> Plasm.avg("age") |> Repo.one
  """
  @spec avg(Ecto.Queryable, String.t) :: Ecto.Queryable
  def avg(query, field_name) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> avg(field_name)
  end
  @spec avg(Ecto.Queryable, atom) :: Ecto.Queryable
  def avg(query, field_name) when is_atom(field_name) do
    query
    |> select([x], avg(field(x, ^field_name)))
  end

  @doc """
  Builds a count query.

      Puppy |> Plasm.count |> Repo.one
  """
  @spec count(Ecto.Queryable) :: Ecto.Queryable
  def count(query) do
    query
    |> select([x], count(x.id))
  end

  @doc """
  Builds a distinct count query for a given field.

      Puppy |> Plasm.count_distinct(:name) |> Repo.one

      Puppy |> Plasm.count_distinct("age") |> Repo.one
  """
  @spec count_distinct(Ecto.Queryable, String.t) :: Ecto.Queryable
  def count_distinct(query, field_name) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> count_distinct(field_name)
  end
  @spec count_distinct(Ecto.Queryable, atom) :: Ecto.Queryable
  def count_distinct(query, field_name) when is_atom(field_name) do
    query
    |> select([x], count(field(x, ^field_name), :distinct))
  end

  @doc """
  Builds a distinct query for a given field.

      Puppy |> Plasm.distinct_by(:age) |> Repo.all

      Puppy |> Plasm.distinct_by("name") |> Repo.all
  """
  @spec distinct_by(Ecto.Queryable, String.t) :: Ecto.Queryable
  def distinct_by(query, field_name) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> distinct_by(field_name)
  end
  @spec distinct_by(Ecto.Queryable, atom) :: Ecto.Queryable
  def distinct_by(query, field_name) when is_atom(field_name) do
    query
    |> distinct([x], field(x, ^field_name))
  end

  @doc """
  Builds a query that finds all records before a specified date or date and time for a specified field name.

      Puppy |> Plasm.earlier_than(:updated_at, ecto_date_time) |> Repo.all

      Puppy |> Plasm.earlier_than(:updated_at, "2014-04-17") |> Repo.all
  """
  @spec earlier_than(Ecto.Queryable, atom, %Ecto.DateTime{}) :: Ecto.Queryable
  def earlier_than(query, field_name, %Ecto.DateTime{} = ecto_date_time) when is_atom(field_name) do
    query
    |> where([x], field(x, ^field_name) < type(^ecto_date_time, Ecto.DateTime))
  end
  @spec earlier_than(Ecto.Queryable, atom, %Ecto.Date{}) :: Ecto.Queryable
  def earlier_than(query, field_name, %Ecto.Date{} = ecto_date) when is_atom(field_name) do
    query
    |> where([x], field(x, ^field_name) < type(^ecto_date, Ecto.Date))
  end
  @spec earlier_than(Ecto.Queryable, atom, any) :: Ecto.Queryable
  def earlier_than(query, field_name, castable) when is_atom(field_name) do
    value = case Ecto.DateTime.cast(castable) do
      {:ok, ecto_date_time} -> ecto_date_time
      :error -> Ecto.Date.cast!(castable)
    end

    query
    |> earlier_than(field_name, value)
  end

  @doc """
  Builds a query that finds all records matching any of the primary key values in the provided list or value.

      Puppy |> Plasm.find([1,2,3]) |> Repo.all

      Puppy |> Plasm.find(10) |> Repo.one

      Puppy |> Plasm.find("748192739812839") |> Repo.one
  """
  @spec find(Ecto.Queryable, list) :: Ecto.Queryable
  def find(query, primary_key_values) when is_list(primary_key_values) do
    key = primary_key(query)

    query
    |> where_all([{key, primary_key_values}])
  end
  @spec find(Ecto.Queryable, any) :: Ecto.Queryable
  def find(query, primary_key_value) do
    key = primary_key(query)

    query
    |> where_all([{key, primary_key_value}])
  end

  @doc """
  Builds a query that finds the first record after sorting by a specified field name ascending.

  Optionally, provide an integer `n` to find only the first `n` records.

      Puppy |> Plasm.earliest(:inserted_at) |> Repo.one

      Puppy |> Plasm.earliest(:inserted_at, 20) |> Repo.all
  """
  @spec earliest(Ecto.Queryable, atom) :: Ecto.Queryable
  def earliest(query, field_name) when is_atom(field_name) do
    query
    |> earliest(field_name, 1)
  end
  @spec earliest(Ecto.Queryable, atom, integer) :: Ecto.Queryable
  def earliest(query, field_name, n) when is_atom(field_name) and is_integer(n) do
    query
    |> order_by(asc: ^field_name)
    |> limit(^n)
  end

  @doc """
  Builds a query that finds the last record after sorting by a specified field name ascending.

  Optionally, provide an integer `n` to find only the last `n` records.

      Puppy |> Plasm.latest(:inserted_at) |> Repo.one

      Puppy |> Plasm.latest(:inserted_at, 20) |> Repo.all
  """
  @spec latest(Ecto.Queryable, atom) :: Ecto.Queryable
  def last_inserted(query, field_name) when is_atom(field_name) do
    query
    |> last_inserted(1, field_name)
  end
  @spec latest(Ecto.Queryable, atom, integer) :: Ecto.Queryable
  def last_inserted(query, field_name, n) when is_atom(field_name) and is_integer(n) do
    query
    |> order_by(desc: ^field_name)
    |> limit(^n)
  end

  @doc """
  Builds a query that finds all records after a specified field name and date or date and time.

      Puppy |> Plasm.later_than(ecto_date_time) |> Repo.all

      Puppy |> Plasm.later_than("2014-04-17") |> Repo.all
  """
  @spec later_than(Ecto.Queryable, atom, %Ecto.DateTime{}) :: Ecto.Queryable
  def later_than(query, field_name, %Ecto.DateTime{} = ecto_date_time) when is_atom(field_name) do
    query
    |> where([x], field(x, ^field_name) > type(^ecto_date_time, Ecto.DateTime))
  end
  @spec later_than(Ecto.Queryable, atom, %Ecto.Date{}) :: Ecto.Queryable
  def later_than(query, field_name, %Ecto.Date{} = ecto_date) when is_atom(field_name) do
    query
    |> where([x], field(x, ^field_name) > type(^ecto_date, Ecto.Date))
  end
  @spec later_than(Ecto.Queryable, atom, any) :: Ecto.Queryable
  def later_than(query, field_name, castable) when is_atom(field_name) do
    value = case Ecto.DateTime.cast(castable) do
      {:ok, ecto_date_time} -> ecto_date_time
      :error -> Ecto.Date.cast!(castable)
    end

    query
    |> later_than(field_name, value)
  end

  @doc """
  Builds a max query for a given field.

      Puppy |> Plasm.max(:age) |> Repo.one

      Puppy |> Plasm.max("age") |> Repo.one
  """
  # @spec max(Ecto.Queryable, String.t) :: Ecto.Queryable
  # def max(query, field_name) when is_binary(field_name) do
  #   field_name = String.to_atom(field_name)
  #
  #   query
  #   |> max(field_name)
  # end
  @spec max(Ecto.Queryable, String.t) :: Ecto.Queryable
  def max(query, field_name) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> __MODULE__.max(field_name)
  end
  @spec max(Ecto.Queryable, atom) :: Ecto.Queryable
  def max(query, field_name) when is_atom(field_name) do
    query
    |> select([x], max(field(x, ^field_name)))
  end

  @doc """
  Builds a min query for a given field.

      Puppy |> Plasm.min(:age) |> Repo.one

      Puppy |> Plasm.min("age") |> Repo.one
  """
  @spec min(Ecto.Queryable, String.t) :: Ecto.Queryable
  def min(query, field_name) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> __MODULE__.min(field_name)
  end
  @spec min(Ecto.Queryable, atom) :: Ecto.Queryable
  def min(query, field_name) when is_atom(field_name) do
    query
    |> select([x], min(field(x, ^field_name)))
  end

  @doc """
  Builds a query that finds all records on a specified date for a specified field name.

      Puppy |> Plasm.on(:inserted_at, ecto_date) |> Repo.all

      Puppy |> Plasm.on(:inserted_at, "2014-04-17") |> Repo.all
  """
  @spec on(Ecto.Queryable, atom, %Ecto.Date{}) :: Ecto.Queryable
  def on(query, field_name, %Ecto.Date{} = ecto_date) when is_atom(field_name) do
    next_day_ecto_date =
      ecto_date
      |> Ecto.Date.to_erl
      |> :calendar.date_to_gregorian_days
      |> Kernel.+(1)
      |> :calendar.gregorian_days_to_date
      |> Ecto.Date.from_erl

    query
    |> where([x], field(x, ^field_name) >= type(^ecto_date, Ecto.Date) and field(x, ^field_name) < type(^next_day_ecto_date, Ecto.Date))
  end
  @spec on(Ecto.Queryable, atom, any) :: Ecto.Queryable
  def on(query, field_name, castable) when is_atom(field_name) do
    {:ok, ecto_date} = Ecto.Date.cast(castable)
    query
    |> on(field_name, ecto_date)
  end

  @doc """
  Builds a query that finds all records on or after a specified date for a specified field name.

      Puppy |> Plasm.on_or_later_than(ecto_date) |> Repo.all

      Puppy |> Plasm.on_or_later_than("2014-04-17") |> Repo.all
  """
  @spec on_or_later_than(Ecto.Queryable, atom, %Ecto.Date{}) :: Ecto.Queryable
  def on_or_later_than(query, field_name, %Ecto.Date{} = ecto_date) when is_atom(field_name) do
    query
    |> where([x], field(x, ^field_name) >= type(^ecto_date, Ecto.Date))
  end
  @spec on_or_later_than(Ecto.Queryable, atom, any) :: Ecto.Queryable
  def on_or_later_than(query, field_name, castable) when is_atom(field_name) do
    {:ok, ecto_date} = Ecto.Date.cast(castable)
    query
    |> on_or_later_than(field_name, ecto_date)
  end

  @doc """
  Builds a query that finds all records on or before a specified date for a specified field name.

      Puppy |> Plasm.on_or_earlier_than(ecto_date) |> Repo.all

      Puppy |> Plasm.on_or_earlier_than("2014-04-17") |> Repo.all
  """
  @spec on_or_earlier_than(Ecto.Queryable, atom, %Ecto.Date{}) :: Ecto.Queryable
  def on_or_earlier_than(query, field_name, %Ecto.Date{} = ecto_date) when is_atom(field_name) do
    next_day_ecto_date =
      ecto_date
      |> Ecto.Date.to_erl
      |> :calendar.date_to_gregorian_days
      |> Kernel.+(1)
      |> :calendar.gregorian_days_to_date
      |> Ecto.Date.from_erl

    query
    |> where([x], field(x, ^field_name) < type(^next_day_ecto_date, Ecto.Date))
  end
  @spec on_or_earlier_than(Ecto.Queryable, atom, any) :: Ecto.Queryable
  def on_or_earlier_than(query, field_name, castable) when is_atom(field_name) do
    {:ok, ecto_date} = Ecto.Date.cast(castable)
    query
    |> on_or_earlier_than(field_name, ecto_date)
  end

  @doc """
  Builds a query that grabs a random record.

  Optionally, provide an integer `n` to fetch `n` random records.

      Puppy |> Plasm.random |> Repo.one

      Puppy |> Plasm.random(20) |> Repo.all
  """
  @spec random(Ecto.Queryable) :: Ecto.Queryable
  def random(query) do
    query
    |> random(1)
  end
  @spec random(Ecto.Queryable, integer) :: Ecto.Queryable
  def random(query, n) when is_integer(n) do
    # TODO: support databases other than postgres
    query
    |> order_by([_], fragment("RANDOM()"))
    |> limit(^n)
  end

  @doc """
  Builds a sum query for a given field.

      Puppy |> Plasm.sum(:age) |> Repo.one

      Puppy |> Plasm.sum("age") |> Repo.one
  """
  @spec sum(Ecto.Queryable, String.t) :: Ecto.Queryable
  def sum(query, field_name) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> sum(field_name)
  end
  @spec sum(Ecto.Queryable, atom) :: Ecto.Queryable
  def sum(query, field_name) when is_atom(field_name) do
    query
    |> select([x], sum(field(x, ^field_name)))
  end

  @doc """
  Builds a query that finds all records matching all specified field names and values.

  Values can be lists or non-lists.

  When the values are all non-lists, it simply delegates to `Ecto.Query.where`.

  When there is at least one list value, it builds the query itself, using `in` for lists.

      Puppy |> Plasm.where_all(name: "Fluffy", age: 3) |> Repo.all

      Puppy |> Plasm.where_all(name: "Fluffy", age: [3,5,10]) |> Repo.all
  """
  @spec where_all(Ecto.Queryable, list) :: Ecto.Queryable
  def where_all(query, field_names_and_values) do
    contains_at_least_one_list = Keyword.values(field_names_and_values)
                                 |> Enum.any?(fn (value) -> is_list(value) end)
    query
    |> do_where_all(field_names_and_values, contains_at_least_one_list)
  end

  @doc """
  Builds a query that finds all records matching none of the specified field names and values.

  Values can be lists or non-lists.

  Non-list expressions result in a `!=` comparison.

  List expressions result in a `not in` comparison.

      Puppy |> Plasm.where_none(name: "Fluffy", age: 3) |> Repo.all

      Puppy |> Plasm.where_none(name: "Fluffy", age: [3,5,10]) |> Repo.all
  """
  @spec where_all(Ecto.Queryable, list) :: Ecto.Queryable
  def where_none(query, field_names_and_values) do
    Enum.reduce(field_names_and_values, query, fn ({field_name, field_value}, query) ->
      generate_where_clause_for_where_none(query, field_name, field_value)
    end)
  end




  # PRIVATE ##################################################

  defp primary_key(query) do
    [key] = model(query).__schema__(:primary_key)
    key
  end

  defp model(%Ecto.Query{from: {_table_name, model_or_query}}) do
    model(model_or_query)
  end
  defp model(model), do: model

  defp generate_where_clause_for_where_all(query, field_name, field_value) when is_list(field_value) do
    query
    |> where([x], field(x, ^field_name) in ^field_value)
  end
  defp generate_where_clause_for_where_all(query, field_name, field_value) do
    query
    |> where([x], field(x, ^field_name) == ^field_value)
  end

  defp generate_where_clause_for_where_none(query, field_name, field_value) when is_list(field_value) do
    query
    |> where([x], not field(x, ^field_name) in ^field_value)
  end
  defp generate_where_clause_for_where_none(query, field_name, field_value) do
    query
    |> where([x], field(x, ^field_name) != ^field_value)
  end

  defp do_where_all(query, field_names_and_values, true) do
    Enum.reduce(field_names_and_values, query, fn ({field_name, field_value}, query) ->
      generate_where_clause_for_where_all(query, field_name, field_value)
    end)
  end

  defp do_where_all(query, field_names_and_values, false) do
    query
    |> where(^field_names_and_values)
  end
end
