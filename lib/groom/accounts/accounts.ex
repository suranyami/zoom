defmodule Groom.Accounts do
  @moduledoc """
    Temporary Account Data Context.
  """

  @users %{
    "1" => %{name: "Norm Smith", age: 33},
    "2" => %{name: "Fred Nurk", age: 22}
  }

  def find_user(id) do
    @users[id]
  end
end
