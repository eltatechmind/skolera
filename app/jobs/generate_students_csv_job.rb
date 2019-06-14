class GenerateStudentsCsvJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @students = Student.all
    csv = @students.to_csv

    file = StringIO.new(csv)
    foo = Studentcsv.new
    foo.csv = file
    foo.csv.instance_write(:content_type, 'text/csv')
    foo.csv.instance_write(:file_name, "students-#{Date.today}.csv")
    foo.save!
  end
end
