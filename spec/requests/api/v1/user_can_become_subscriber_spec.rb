RSpec.describe 'POST /api/v1/subscriptions', type: :request do
  describe 'sucessfully' do
    let(:user) { create(:user)}
    let(:user_credentials) { user.create_new_auth_token }
    let(:user_headers) { {HTTP_ACCEPT: 'application/json'}.merge!(user_credentials) }
    before do
      post "/api/v1/subscriptions",
      params: {
        stripeToken: StripeMock.create_test_helper.generate_card_token
      },
      headers: user_headers
    end

    it 'is expected to return 200 response status' do
      expect(response.status).to eq 200      
    end
    
    it 'is expected to return paid: true' do
      expect(JSON.parse(response.body)["paid"]).to eq true     
    end

    it 'is expected to return success message' do
      expect(JSON.parse(response.body)["message"]).to eq "Successful payment, you are now a subscriber."     
    end


  end
end