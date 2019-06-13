require 'rails_helper'

RSpec.describe 'Courses API' do
  # Initialize the test data
  let!(:teacher) { create(:teacher) }
  let!(:courses) { create_list(:course, 20, teacher_id: teacher.id) }
  let(:teacher_id) { teacher.id }
  let(:id) { courses.first.id }
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

  # Test suite for GET /teachers/:teacher_id/courses
  describe 'GET /teachers/:teacher_id/courses' do
    before { get "/teachers/#{teacher_id}/courses", headers: @headers }

    context 'when teacher exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all teacher courses' do
        expect(JSON.parse(response.body)["data"].count).to eq(20)
      end
    end

    context 'when teacher does not exist' do
      let(:teacher_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Teacher/)
      end
    end
  end

  # Test suite for GET /teachers/:teacher_id/courses/:id
  describe 'GET /teachers/:teacher_id/courses/:id' do
    before { get "/teachers/#{teacher_id}/courses/#{id}", headers: @headers }

    context 'when teacher course exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the course' do
        expect(JSON.parse(response.body)["data"]["id"].to_i).to eq(id)
      end
    end

    context 'when teacher course does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Course/)
      end
    end
  end

  # Test suite for POST /teachers/:teacher_id/courses
  describe 'POST /teachers/:teacher_id/courses' do
    let(:valid_attributes) { { name: 'Math Five'} }

    context 'when request attributes are valid' do
      before { post "/teachers/#{teacher_id}/courses", params: valid_attributes, headers: @headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/teachers/#{teacher_id}/courses", params: {}, headers: @headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /teachers/:teacher_id/courses/:id
  describe 'PUT /teachers/:teacher_id/courses/:id' do
    let(:valid_attributes) { { name: 'Math Seven' } }

    before { put "/teachers/#{teacher_id}/courses/#{id}", params: valid_attributes, headers: @headers }

    context 'when course exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the course' do
        updated_course = Course.find(id)
        expect(updated_course.name).to match(/Math Seven/)
      end
    end

    context 'when the Course does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Course/)
      end
    end
  end

  # Test suite for DELETE /teachers/:teacher_id/courses/:id
  describe 'DELETE /teachers/:teacher_id/courses/:id' do
    before { delete "/teachers/#{teacher_id}/courses/#{id}", headers: @headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end