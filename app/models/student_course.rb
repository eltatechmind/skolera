class StudentCourse < ApplicationRecord
  belongs_to :student
  belongs_to :course
  validates :course_id, uniqueness: { scope: :student_id }

  def self.to_csv
    attributes = %w{id student_id course_id}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |studentcourse|
        csv << attributes.map{ |attr| studentcourse.send(attr) }
      end
    end
  end
end
