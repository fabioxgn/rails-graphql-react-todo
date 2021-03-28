RSpec.describe Mutations::UpdateTodoMutation, type: :request do
  def mutation(completed:)
    <<~GQL
      mutation {
        updateTodo(input: { id: #{todo.id}, completed: #{completed} }) {
          todo {
            id
            description
            completed
          }
          errors
        }
      }
    GQL
  end

  describe ".resolve" do
    subject(:update_todo) do
      post "/graphql", params: { query: mutation(completed: completed) }
      JSON.parse(response.body)
    end

    let!(:todo) { create(:todo_item) }
    let(:completed) { true }

    it "completes a todo item" do
      update_todo

      expect(todo.reload.completed).to eq true
    end

    context "when validation errors" do
      before do
        todo.description = ""
        todo.save!(validate: false)
      end

      it "returns erros" do
        errors = update_todo["data"]["updateTodo"]["errors"]

        expect(errors).to eq ["Description can't be blank"]
      end
    end
  end
end
