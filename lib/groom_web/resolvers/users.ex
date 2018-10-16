defmodule GroomWeb.Resolvers.Users do
  @moduledoc """
    Queries for user.
  """
  def find(_parent, %{id: id}, _resolution) do
    case Groom.Users.find(id) do
      nil -> {:error, "User ID #{id} not found"}
      user -> {:ok, user}
    end
  end

  def add(_parent, %{name: name, age: age}, _resolution) do
    Groom.Users.add(name, age)
  end

  def list(_parent, _, _resolution) do
    {:ok, Groom.Users.list()}
  end
end
