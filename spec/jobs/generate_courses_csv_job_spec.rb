require 'rails_helper'

RSpec.describe GenerateCoursesCsvJob, type: :job do
  it "Should run the job" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      GenerateCoursesCsvJob.perform_later
    }.to have_enqueued_job(GenerateCoursesCsvJob)
  end
  it "Should increase Csv Model records by 1" do
    expect { GenerateCoursesCsvJob.perform_now }.to change { Csv.where(kind: "courses").count }.by(1)
  end
end
