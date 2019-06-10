class Course < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 6, maximum: 35},
                   uniqueness: { case_sensitive: false }
  belongs_to :teacher
  has_many :student_courses, dependent: :destroy
end
