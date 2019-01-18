defmodule ZoomWeb.Resolvers.Users do
  @moduledoc """
    Queries for user.
  """
  def find(_parent, %{id: id}, _resolution) do
    result = case Zoom.Users.find(id) do
      nil -> {:error, "User ID #{id} not found"}
      user ->
        {:ok, %{name: String.downcase(user.name), age: user.age}}
    end
  end

  def add(_parent, %{name: name, age: age}, _resolution) do
    Zoom.Users.add(name, age)
  end

  def list(_parent, _, _resolution) do
    {:ok, Zoom.Users.list()}
  end

  def count(_parent, _, _) do
    {:ok, Zoom.Users.count()}
  end
end
