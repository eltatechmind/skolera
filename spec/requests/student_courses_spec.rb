require 'rails_helper'

RSpec.describe 'StudentCourses API' do
  # Initialize the test data
  let!(:teacher) { create(:teacher) }
  let!(:courses) { create_list(:course, 4, teacher_id: teacher.id) }
  let!(:student) { create(:student) }
  let!(:student_course1) { create(:student_course, student_id: student.id, course_id: courses.first.id) }
  let!(:student_course2) { create(:student_course, student_id: student.id, course_id: courses.second.id) }
  let!(:student_course3) { create(:student_course, student_id: student.id, course_id: courses.third.id) }
  let(:student_id) { student.id }
  let(:id) { StudentCourse.first.id }
  let(:user) { create(:user) }
  let(:params) do
    {
        email: user.email,
        password: user.password
    }
  end
  before do
    post '/auth/sign_in', params: params
    @headers = {
        "access-token": response.headers["access-token"],
        "uid": response.headers["uid"],
        "client": response.headers["client"],
      }
  end

  # Test suite for GET /students/:student_id/student_courses
  describe 'GET /students/:student_id/student_courses' do
    before { get "/students/#{student_id}/student_courses", headers: @headers }

    context 'when student exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all student studentcourses' do
        expect(json.size).to eq(3)
      end
    end

    context 'when student does not exist' do
      let(:student_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Student/)
      end
    end
  end

  # Test suite for GET /students/:student_id/student_courses/:id
  describe 'GET /students/:student_id/student_courses/:id' do
    before { get "/students/#{student_id}/student_courses/#{id}", headers: @headers }

    context 'when student studentcourse exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the studentcourse' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when student studentcourse does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find StudentCourse/)
      end
    end
  end

  # Test suite for POST /students/:student_id/student_courses
  describe 'POST /students/:student_id/student_courses' do
    let(:valid_attributes) { { course_id: courses.last.id} }

    context 'when request attributes are valid' do
      before { post "/students/#{student_id}/student_courses", params: valid_attributes, headers: @headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/students/#{student_id}/student_courses", params: {}, headers: @headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match("{\"message\":\"Validation failed: Course must exist\"}")
      end
    end
  end

  # Test suite for PUT /students/:student_id/student_courses/:id
  describe 'PUT /students/:student_id/student_courses/:id' do
    let(:valid_attributes) { { course_id: courses.last.id} }

    before { put "/students/#{student_id}/student_courses/#{id}", params: valid_attributes, headers: @headers }

    context 'when course exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the course' do
        updated_studentcourse = StudentCourse.find(id)
        expect(updated_studentcourse.course_id).to eq(courses.last.id)
      end
    end

    context 'when the studentCourse does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find StudentCourse/)
      end
    end
  end

  # Test suite for DELETE /students/:student_id/student_courses/:id
  describe 'DELETE /students/:student_id/student_courses/:id' do
    before { delete "/students/#{student_id}/student_courses/#{id}", headers: @headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end