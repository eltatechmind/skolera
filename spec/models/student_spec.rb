require 'rails_helper'

# Test suite for the Student model
RSpec.describe Student, type: :model do
  # Association test
  # ensure Student model has a 1:m relationship with the StudentCourse model
  it { should have_many(:student_courses).dependent(:destroy) }
  # Validation tests
  # ensure columns name present before saving
  it { should validate_presence_of(:name) }
end