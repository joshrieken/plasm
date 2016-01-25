defmodule Plasm.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    field :age,  :integer
  end
end

defmodule Plasm.UserWithFooPrimaryKey do
  use Ecto.Schema

  @primary_key {:foo, :string, []}
  schema "users2" do
  end
end
