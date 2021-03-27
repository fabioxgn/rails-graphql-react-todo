RSpec.describe Mutations::AddTodoMutation, type: :request do
  def mutation(description:)
    <<~GQL
      mutation {
        addTodo(input: { description: "#{description}" }) {
          todo {
            id
            description
          }
          errors
        }
      }
    GQL
  end

  describe ".resolve" do
    subject(:add_todo) do
      post "/graphql", params: { query: mutation(description: description) }
      JSON.parse(response.body)
    end

    let(:description) { Faker::Lorem.sentence }

    it "creates a todo item" do
      expect do
        add_todo
      end.to change(TodoItem, :count).by(1)
    end

    it "returns a todo item" do
      todo = add_todo["data"]["addTodo"]["todo"]

      expect(todo).to include("id" => be_present, "description" => description)
    end

    context "when validation errors" do
      let(:todo) { instance_double(TodoItem) }

      before do
        allow(TodoItem).to receive(:new).and_return(TodoItem.new)
      end

      it "returns erros" do
        errors = add_todo["data"]["addTodo"]["errors"]

        expect(errors).to eq ["Description can't be blank"]
      end
    end
  end
end
