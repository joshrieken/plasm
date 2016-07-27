defmodule Plasm.Factory do
  use ExMachina.Ecto, repo: Plasm.Repo

  def user_factory do
    %Plasm.User{
      name: "Bill",
      age:  30,
    }
  end
end
