defmodule ZoomWeb.Schema do
  @moduledoc """
    GraphQL schema for ZoomWeb.
  """
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)
  import_types(ZoomWeb.Schema.User)
  alias ZoomWeb.Resolvers

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

    @desc "Count number of users"
    field :count_users, :integer do
      resolve(&Resolvers.Users.count/3)
    end
  end

  mutation do
    field :add_user, :user do
      arg(:name, :string)
      arg(:age, :integer)
      arg(:color, :string)
      arg(:uuid, :string)

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

    field :users, list_of(:user) do
      trigger(:add_user,
        topic: fn _ ->
          "*"
        end
      )

      config(fn _, _info ->
        {:ok, topic: "*"}
      end)
      resolve(&Resolvers.Users.list/3)
    end

    field :count_users, :integer do
      trigger(:add_user,
        topic: fn _ ->
          "*"
        end
      )

      config(fn _, _info ->
        {:ok, topic: "*"}
      end)

      resolve(&Resolvers.Users.count/3)

    end
  end
end
