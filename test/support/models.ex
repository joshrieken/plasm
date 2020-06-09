defmodule Plasm.User do
  use Ecto.Schema
  import Ecto.Query

  schema "users" do
    field :name, :string
    field :age,  :integer
    field :date_of_birth, :date

    timestamps(type: :utc_datetime)
  end

  def for_age(query, age) do
    from u in query,
      where: u.age == ^age
  end
end
