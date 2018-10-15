defmodule GroomWeb.Resolvers.Accounts do
  @moduledoc """
    Queries for user accounts.
  """
  def find_user(_parent, %{id: id}, _resolution) do
    case Groom.Accounts.find_user(id) do
      nil -> {:error, "User ID #{id} not found"}
      user -> {:ok, user}
    end
  end
end
