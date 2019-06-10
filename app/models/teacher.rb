class Teacher < ApplicationRecord
  validates :name, presence: true, length: { minimum: 6, maximum: 35}
end
