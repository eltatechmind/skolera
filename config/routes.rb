Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # edit course teacher
  put '/editcourseteacher/:id', to: 'courses#edit_course_teacher'
  # get all courses exists
  get '/allcourses', to: 'courses#all_courses'
  resources :teachers do
    resources :courses
  end
  # edit course student
  put '/editcoursestudent/:id', to: 'student_courses#edit_course_student'
  # get all StudentCourse records
  get '/allstudentscourses', to: 'student_courses#all_students_courses'
  resources :students do
    resources :student_courses
  end
end
