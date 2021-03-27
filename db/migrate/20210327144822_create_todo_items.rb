class CreateTodoItems < ActiveRecord::Migration[6.1]
  def change
    create_table :todo_items do |t|
      t.string :description, null: false
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
