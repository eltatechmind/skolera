class GenerateCoursesCsvJob < ApplicationJob
  queue_as :default

  def perform(*args)
    file = StringIO.new(Course.all.to_csv)
    foo = Csv.new
    foo.kind = "courses"
    foo.csv = file
    foo.csv.instance_write(:content_type, 'text/csv')
    foo.csv.instance_write(:file_name, "courses-#{Date.today}.csv")
    foo.save!
  end
end
