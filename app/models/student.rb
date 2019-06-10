class Student < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 6, maximum: 35},
                   uniqueness: { case_sensitive: false }
end
