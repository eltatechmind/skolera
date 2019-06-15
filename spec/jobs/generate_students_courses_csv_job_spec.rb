require 'rails_helper'

RSpec.describe GenerateStudentsCoursesCsvJob, type: :job do
  it "Should run the job" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      GenerateStudentsCoursesCsvJob.perform_later
    }.to have_enqueued_job(GenerateStudentsCoursesCsvJob)
  end
  it "Should increase Csv Model records by 1" do
    expect { GenerateStudentsCoursesCsvJob.perform_now }.to change { Csv.where(kind: "students_courses").count }.by(1)
  end
end
