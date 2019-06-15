class GenerateStudentsCoursesCsvJob < ApplicationJob
  queue_as :default

  def perform(*args)
    file = StringIO.new(StudentCourse.all.to_csv)
    foo = Csv.new
    foo.kind = "students_courses"
    foo.csv = file
    foo.csv.instance_write(:content_type, 'text/csv')
    foo.csv.instance_write(:file_name, "students-courses-#{Date.today}.csv")
    foo.save!
  end
end
