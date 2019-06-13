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

  # download teachers csv
  def download_teachers
    @teachers = Teacher.all

    respond_to do |format|
      format.html { send_data @teachers.to_csv, filename: "teachers-#{Date.today}.csv" }
    end
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
