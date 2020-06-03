defmodule Plasm.Factory do
  use ExMachina.Ecto, repo: Plasm.Repo

  def user_factory do
    %Plasm.User{
      name: "Bill",
      age:  30,
      date_of_birth: ~D[1980-01-02]
    }
  end
end
