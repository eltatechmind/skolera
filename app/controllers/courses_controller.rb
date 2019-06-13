class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_teacher, except: [:all_courses, :edit_course_teacher]
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

  # PUT /teachers/:teacher_id/courses/:id (edit name only)
  def update
    @course.update(name: params[:name])
    json_response(@course)
  end

  # DELETE /teachers/:teacher_id/courses/:id
  def destroy
    @course.destroy
    head :no_content
  end

  # GET /teachers/allcourses  (to get all courses)
  def all_courses
    json_response(Course.all)
  end

  # PUT /editcourseteacher/:id (edit teacher_id only)
  def edit_course_teacher
    Course.find_by!(id: params[:id]).update(teacher_id: params[:teacher_id])
    json_response(Course.find_by!(id: params[:id]))
  end



  private

  def course_params
    params.permit(:name, :teacher_id)
  end

  def set_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end

  def set_teacher_course
    @course = @teacher.courses.find_by!(id: params[:id]) if @teacher
  end
end