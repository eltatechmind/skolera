require 'rails_helper'

# Test suite for the Teacher model
RSpec.describe Teacher, type: :model do
  # Association test
  # ensure Teacher model has a 1:m relationship with the Course model
  it { should have_many(:courses).dependent(:destroy) }
  # Validation tests
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end