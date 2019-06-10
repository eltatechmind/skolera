class Course < ApplicationRecord
  validates :name, presence: true, length: { minimum: 6, maximum: 35 }
end
