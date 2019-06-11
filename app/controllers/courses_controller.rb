class CoursesController < ApplicationController
  before_action :set_teacher
  before_action :set_teacher_course, only: [:show, :update, :destroy]

  # GET /teachers/:teacher_id/courses
  def index
    json_response(@teacher.courses)
  end

  # GET /teachers/:teacher_id/courses/:id
  def show
    json_response(@course)
  end

  # POST /teachers/:teacher_id/courses
  def create
    @teacher.courses.create!(course_params)
    json_response(@teacher, :created)
  end

  # PUT /teachers/:teacher_id/courses/:id
  def update
    @course.update(course_params)
    head :no_content
  end

  # DELETE /teachers/:teacher_id/courses/:id
  def destroy
    @course.destroy
    head :no_content
  end

  private

  def course_params
    params.permit(:name)
  end

  def set_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end

  def set_teacher_course
    @course = @teacher.courses.find_by!(id: params[:id]) if @teacher
  end
end