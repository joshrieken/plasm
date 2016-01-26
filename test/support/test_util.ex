defmodule Plasm.TestUtil do
  def query_to_string(query) do
    Inspect.Ecto.Query.to_string(query)
  end
end
