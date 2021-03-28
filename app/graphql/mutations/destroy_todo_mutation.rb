module Mutations
  class DestroyTodoMutation < Mutations::BaseMutation
    argument :id, ID, required: true

    type Types::TodoItemType

    def resolve(id:)
      TodoItem.find(id).tap do |todo|
        todo.destroy!
      end
    end
  end
end
