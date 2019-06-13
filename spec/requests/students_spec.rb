require 'rails_helper'

RSpec.describe 'Students API', type: :request do
  # initialize test data 
  let!(:students) { create_list(:student, 10) }
  let(:student_id) { students.first.id }
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

  # Test suite for GET /students
  describe 'GET /students' do
    # make HTTP get request before each example
    before { get '/students', headers: @headers }

    it 'returns students' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(JSON.parse(response.body)["data"].count).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /students/:id
  describe 'GET /students/:id' do
    before { get "/students/#{student_id}", headers: @headers }

    context 'when the record exists' do
      it 'returns the student' do
        expect(json).not_to be_empty
        expect(JSON.parse(response.body)["data"]["id"].to_i).to eq(student_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:student_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Student/)
      end
    end
  end

  # Test suite for POST /students
  describe 'POST /students' do
    # valid payload
    let(:valid_attributes) { { name: 'Ahmed Fouad' } }

    context 'when the request is valid' do
      before { post '/students', params: valid_attributes, headers: @headers }

      it 'creates a student' do
        expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq('Ahmed Fouad')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/students', params: { name: "" }, headers: @headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"message\":\"Validation failed: Name can't be blank, Name is too short (minimum is 6 characters)\"}")
      end
    end
  end

  # Test suite for PUT /students/:id
  describe 'PUT /students/:id' do
    let(:valid_attributes) { { name: 'karim elsayed' } }

    context 'when the record exists' do
      before { put "/students/#{student_id}", params: valid_attributes, headers: @headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /students/:id
  describe 'DELETE /students/:id' do
    before { delete "/students/#{student_id}", headers: @headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
