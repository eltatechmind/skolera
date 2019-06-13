class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student, only: [:show, :update, :destroy]
  # GET /students
  def index
    @student = Student.all
    json_response(@student)
  end

  # POST /students
  def create
    @student = Student.create!(student_params)
    json_response(@student, :created)
  end

  # GET /students/:id
  def show
    json_response(@student)
  end

  # PUT /students/:id
  def update
    @student.update(student_params)
    head :no_content
  end

  # DELETE /students/:id
  def destroy 
    @student.destroy
    head :no_content
  end

  # download students csv
  def download_students
    @students = Student.all

    respond_to do |format|
      format.html { send_data @students.to_csv, filename: "students-#{Date.today}.csv" }
    end
  end

  private

  def student_params
    # whitelist params
    params.permit(:name)
  end

  def set_student
    @student = Student.find(params[:id])
  end
end
