class TeachersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_teacher, only: [:show, :update, :destroy]
  # GET /teachers
  def index
    @teacher = Teacher.all
    json_response(@teacher)
  end

  # POST /teachers
  def create
    @teacher = Teacher.create!(teacher_params)
    json_response(@teacher, :created)
  end

  # GET /teachers/:id
  def show
    json_response(@teacher)
  end

  # PUT /teachers/:id
  def update
    @teacher.update(teacher_params)
    head :no_content
  end

  # DELETE /teachers/:id
  def destroy
    @teacher.destroy
    head :no_content
  end

  # create teachers csv
  def create_teachers_csv
    GenerateTeachersCsvJob.perform_later
    json_response("Creating Teachers CSV file..., visit '../downloadteachers' endpoint and refresh.")
  end

  # download created teachers csvs (ordered by last created)
  def download_teachers
    csv = []
    Csv.where(kind: "teachers").order("created_at DESC").each do |record|
      csv << request.base_url + record.csv.url
    end
    json_response(csv)
  end

  private

  def teacher_params
    # whitelist params
    params.permit(:name)
  end

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end
end
