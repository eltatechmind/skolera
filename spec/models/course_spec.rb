require 'rails_helper'

# Test suite for the Course model
RSpec.describe Course, type: :model do
  # Association test
  # ensure a course record belongs to a single teacher record
  it { should belong_to(:teacher) }
  # ensure Course model has a 1:m relationship with the StudentCourse model
  it { should have_many(:student_courses).dependent(:destroy) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
