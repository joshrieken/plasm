defmodule Plasm.Case do
  use ExUnit.CaseTemplate

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Plasm.Repo)
  end

  using do
    quote do
      require Ecto.Query

      doctest Plasm
    end
  end
end
