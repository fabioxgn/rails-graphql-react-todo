RSpec.describe Mutations::DestroyTodoMutation, type: :request do
  def mutation(id:)
    <<~GQL
      mutation {
        destroyTodo(input: { id: #{id} })
        {
          id
          description
          completed
        }
      }
    GQL
  end

  describe ".resolve" do
    subject(:destroy_todo) do
      post "/graphql", params: { query: mutation(id: todo.id) }
      JSON.parse(response.body)
    end

    let!(:todo) { create(:todo_item) }

    it "destroys a todo item" do
      expect { destroy_todo }.to change(TodoItem, :count).by(-1)
    end

    it "returns the destroyed todo item" do
      todo_item = destroy_todo["data"]["destroyTodo"]

      expect(todo_item["id"]).to eq todo.id.to_s
    end
  end
end
