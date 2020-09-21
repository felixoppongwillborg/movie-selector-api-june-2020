RSpec.describe 'Get /api/v1/movies', type: :request do
  describe 'successfully' do
    before do 
      get '/api/v1/movies/random'
    end

    it 'is expected to get a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return a movie' do
      expect(response_json["movie"]["title"]).to eq "For Your Eyes Only"
    end

    it 'is expected to not return an array' do
      expect(response_json).to_not be_an Array
    end
  end
end
