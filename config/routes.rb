Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # download all teachers as csv
  get '/downloadteachers', to: 'teachers#download_teachers'

  # create students csv
  get '/createstudentscsv', to: 'students#create_students_csv'
  # download all students as csv
  get '/downloadstudents', to: 'students#download_students'

  # download all studentscourses as csv
  get '/downloadstudentscourses', to: 'student_courses#download_students_courses'

  # download all courses as csv
  get '/downloadcourses', to: 'courses#download_courses'

  # edit course teacher
  put '/editcourseteacher/:id', to: 'courses#edit_course_teacher'

  # get all courses exists
  get '/allcourses', to: 'courses#all_courses'

  # edit course student
  put '/editcoursestudent/:id', to: 'student_courses#edit_course_student'

  # get all StudentCourse records
  get '/allstudentscourses', to: 'student_courses#all_students_courses'

  resources :teachers do
    resources :courses
  end

  resources :students do
    resources :student_courses
  end
end
