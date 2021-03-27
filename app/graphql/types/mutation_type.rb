module Types
  class MutationType < Types::BaseObject
    field :add_todo, mutation: Mutations::AddTodoMutation
  end
end
