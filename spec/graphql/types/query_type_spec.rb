RSpec.describe Types::QueryType do
  describe "todos" do
    let!(:todos) { create_pair(:todo_item) }

    let(:query) do
      %(query {
        todos {
          id
          description
        }
      })
    end

    subject(:result) do
      GraphqlTodoSchema.execute(query).as_json
    end

    it "returns all todos" do
      expect(result.dig("data", "todos")).to match_array(
        todos.map { |todo| { "id" => todo.id.to_s, "description" => todo.description } }
      )
    end
  end
end