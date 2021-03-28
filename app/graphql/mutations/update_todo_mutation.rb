module Mutations
  class UpdateTodoMutation < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :completed, Boolean, required: true

    field :todo, Types::TodoItemType, null: true
    field :errors, [String], null: true

    def resolve(id:, completed:)
      todo = TodoItem.find(id)

      if todo.update(completed: completed)
        { todo: todo }
      else
        { errors: todo.errors.full_messages }
      end
    end
  end
end
