Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/teachers/editcourseteacher/:id', to: 'courses#edit_course_teacher'
  get '/teachers/allcourses', to: 'courses#all_courses'
  resources :teachers do
    resources :courses
  end
end
