class Teacher < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 6, maximum: 35},
                   uniqueness: { case_sensitive: false }
  has_many :courses, dependent: :destroy
end
