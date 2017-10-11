defmodule Plasm.Repo.Migrations.CreateTestTables do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :age,  :integer

      timestamps(type: :utc_datetime)
    end
  end
end
