defmodule Plasm.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    field :age,  :integer

    timestamps
  end
end
