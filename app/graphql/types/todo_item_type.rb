module Types
  class TodoItemType < Types::BaseObject
    field :id, ID, null: false
    field :description, String, null: false
    field :completed, Boolean, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :errors, [String], null: true

    def errors
      object.errors.full_messages
    end
  end
end
