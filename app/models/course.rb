class Course < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 6, maximum: 35}
  belongs_to :teacher
  has_many :student_courses, dependent: :destroy

  def self.to_csv
    attributes = %w{id name teacher_id}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |course|
        csv << attributes.map{ |attr| course.send(attr) }
      end
    end
  end
end
