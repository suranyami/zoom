defmodule GroomWeb.Schema do
  @moduledoc """
    GraphQL schema for GroomWeb.
  """
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)
  import_types(GroomWeb.Schema.User)
  alias GroomWeb.Resolvers

  query do
    @desc "Get a user"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Users.find/3)
    end

    @desc "Get all users"
    field :users, list_of(:user) do
      resolve(&Resolvers.Users.list/3)
    end
  end

  mutation do
    field :add_user, :user do
      arg(:name, non_null(:string))
      arg(:age, non_null(:integer))
      resolve(&Resolvers.Users.add/3)
    end
  end

  subscription do
    field :user_added, :user do
      trigger(:add_user,
        topic: fn _ ->
          "*"
        end
      )

      config(fn _, _info ->
        {:ok, topic: "*"}
      end)
    end
  end
end
