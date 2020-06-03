defmodule Plasm.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    field :age,  :integer
    field :date_of_birth, :date

    timestamps(type: :utc_datetime)
  end
end
