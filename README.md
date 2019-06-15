## This is a short Documentation on School API (SKOLERA Task):
- is an API which is used as registration system, using http requests (restful)
- only admins can visit endpoints and send requests, to be an admin you must register through devise endpoints
- there are 4 background jobs implemented using sidekiq with redis server for creating csv files contain all data for any model you want from the 4 main models (students, courses, teachers, students_courses)
- data sent back for the 4 main models serialized using fastjsonapi gem 
### Database
- Consists of 6 models, 4 of them with relations (teachers has many courses, courses and students are many to many), with some validations on model and database levels, index is added for speed, 1 model for devise (the admins who can visit all other models), 1 model for saving csv files using paperclip 

![alt text](https://res.cloudinary.com/elta3lab/image/upload/v1560632464/Screenshot_from_2019-06-15_22-58-42.png)

###  Routes
- nested resources, where you can apply crud operations on teachers model, on courses belongs to a specific teacher, on students model, on students_courses model which show courses belongs to specific student

![alt text](https://res.cloudinary.com/elta3lab/image/upload/v1560633716/Screenshot_from_2019-06-15_23-21-28.png)

- some custom routes created too to be able to serve needs of extracting more data, applying specific editing, like get all courses exists in the system, get all students_courses records, edit course teacher & edit course student

![alt text](https://res.cloudinary.com/elta3lab/image/upload/v1560634175/Screenshot_from_2019-06-15_23-29-19.png)

### Devise
- using devise for authentication, with the whole list of endpoints for registration, login, logout, edit info, etc

![alt text](https://res.cloudinary.com/elta3lab/image/upload/v1560634421/Screenshot_from_2019-06-15_23-32-22.png)

- here are some examples
1) to register a new email, send post request to endpoint /auth with json data of email, password, password confirmation

![alt text](https://res.cloudinary.com/elta3lab/image/upload/v1560634934/Screenshot_from_2019-06-15_23-41-37.png)

2) to login, send post request to endpoint /auth/sign_in with params of email and password, after sending it go to headers and copy (access-token, client, uid) key and value, which will then be used to communicate with all other protected endpoints which require login

![alt text](https://res.cloudinary.com/elta3lab/image/upload/v1560635209/Screenshot_from_2019-06-15_23-46-28.png)

3) if you try to visit any url without adding the 3 headers from the previous step, then an error will be sent back requiring you to login

![alt text](https://res.cloudinary.com/elta3lab/image/upload/v1560635867/Screenshot_from_2019-06-15_23-57-34.png)

but if you send the 3 key values headers, a response with serialized data using fastjsonapi will appear

![alt text](https://res.cloudinary.com/elta3lab/image/upload/v1560635897/Screenshot_from_2019-06-15_23-57-01.png)
