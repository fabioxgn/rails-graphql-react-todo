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
    let(:description) { Faker::Lorem.sentence }

    it "creates a todo item" do
      expect do
        post "/graphql", params: { query: mutation(description: description) }
      end.to change(TodoItem, :count).by(1)
    end

    it "returns a todo item" do
      post "/graphql", params: { query: mutation(description: description) }
      json = JSON.parse(response.body)
      data = json["data"]["addTodo"]["todo"]

      expect(data).to include(
        "id" => be_present,
        "description" => description
      )
    end

    context "when validation errors" do
      let(:todo) { instance_double(TodoItem) }

      before do
        allow(TodoItem).to receive(:new).and_return(TodoItem.new)
      end

      it "returns erros" do
        post "/graphql", params: { query: mutation(description: "ignored") }
        json = JSON.parse(response.body)
        puts json
        errors = json["data"]["addTodo"]["errors"]

        expect(errors).to eq ["Description can't be blank"]
      end
    end
  end
end
