module Mutations
  class AddTodoMutation < Mutations::BaseMutation
    argument :description, String, required: true

    field :todo, Types::TodoItemType, null: true
    field :errors, [String], null: false

    def resolve(description:)     
      item = TodoItem.new(description: description)

      if item.save
        { todo: item }
      else
        { errors: item.errors.full_messages }
      end
    end
  end
end