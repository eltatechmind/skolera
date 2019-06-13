module Response
  def json_response(object, status = :ok)
    if (object.class.to_s == "Teacher::ActiveRecord_Relation" || object.class.to_s == "Teacher" || object.class.to_s == "Teacher::ActiveRecord_Associations_CollectionProxy")
      render json: TeacherSerializer.new(object).serialized_json, status: status
    elsif (object.class.to_s == "Course::ActiveRecord_Relation" || object.class.to_s == "Course" || object.class.to_s == "Course::ActiveRecord_Associations_CollectionProxy")
      render json: CourseSerializer.new(object).serialized_json, status: status
    elsif (object.class.to_s == "Student::ActiveRecord_Relation" || object.class.to_s == "Student"  || object.class.to_s == "Student::ActiveRecord_Associations_CollectionProxy")
      render json: StudentSerializer.new(object).serialized_json, status: status
    elsif (object.class.to_s == "StudentCourse::ActiveRecord_Relation" || object.class.to_s == "StudentCourse" || object.class.to_s == "StudentCourse::ActiveRecord_Associations_CollectionProxy")
      render json: StudentCourseSerializer.new(object).serialized_json, status: status 
    else
      render json: object, status: status
    end
  end
end