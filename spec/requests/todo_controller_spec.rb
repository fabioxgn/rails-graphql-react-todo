RSpec.describe TodoController do
  describe "#index" do
    subject(:index) { get "/" }

    before { index }

    it { expect(response).to render_template(:index) }
  end
end
