module Types
  class MutationType < Types::BaseObject
    field :add_todo, mutation: Mutations::AddTodoMutation
    field :update_todo, mutation: Mutations::UpdateTodoMutation
    field :destroy_todo, mutation: Mutations::DestroyTodoMutation
  end
end
