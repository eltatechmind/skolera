require 'rails_helper'

RSpec.describe GenerateTeachersCsvJob, type: :job do
  it "Should run the job" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      GenerateTeachersCsvJob.perform_later
    }.to have_enqueued_job(GenerateTeachersCsvJob)
  end
  it "Should increase Csv Model records by 1" do
    expect { GenerateTeachersCsvJob.perform_now }.to change { Csv.where(kind: "teachers").count }.by(1)
  end
end
