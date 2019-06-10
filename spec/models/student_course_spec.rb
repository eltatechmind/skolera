require 'rails_helper'

# Test suite for the StudentCourse model
RSpec.describe StudentCourse, type: :model do
  # Association test
  # ensure a student_course record belongs to a single student record
  it { should belong_to(:student) }
  # ensure a student_course record belongs to a single course record
  it { should belong_to(:course) }
end