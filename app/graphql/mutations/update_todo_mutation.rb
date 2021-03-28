module Mutations
  class UpdateTodoMutation < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :completed, Boolean, required: true

    type Types::TodoItemType

    def resolve(id:, completed:)
      TodoItem.find(id).tap do |todo|
        todo.update(completed: completed)
      end
    end
  end
end
