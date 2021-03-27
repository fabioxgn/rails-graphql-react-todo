module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    
    field :todos, [Types::TodoItemType], null: false, description: "An example field added by the generator"
    def todos
      TodoItem.all
    end
  end
end
