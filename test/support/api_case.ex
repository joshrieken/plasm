defmodule Plasm.ApiCase do
  use ExUnit.CaseTemplate

  setup do
    Ecto.Adapters.SQL.begin_test_transaction(Plasm.Repo)

    ExUnit.Callbacks.on_exit fn ->
      Ecto.Adapters.SQL.rollback_test_transaction(Plasm.Repo)
    end
  end

  using do
    quote do
      require Ecto.Query

      import Plasm.TestUtil

      doctest Plasm
    end
  end
end
