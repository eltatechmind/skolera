require 'rails_helper'

RSpec.describe GenerateStudentsCsvJob, type: :job do
  it "Should run the job" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      GenerateStudentsCsvJob.perform_later
    }.to have_enqueued_job(GenerateStudentsCsvJob)
  end
  it "Should increase Csv Model records by 1" do
    expect { GenerateStudentsCsvJob.perform_now }.to change { Csv.where(kind: "students").count }.by(1)
  end
end
