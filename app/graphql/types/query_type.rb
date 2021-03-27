module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :todos, [Types::TodoItemType], null: false, description: "All todo items"
    def todos
      TodoItem.all
    end
  end
end
