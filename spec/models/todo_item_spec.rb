RSpec.describe TodoItem do
  it { is_expected.to validate_presence_of(:description) }
end