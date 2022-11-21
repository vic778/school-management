RSpec.describe "Sessions", type: :request do
  describe "POST /create" do
    it "creates a new user" do
      post '/api/users/register', params: { user: { email: 'test@gmail.com', name: 'hello', password: 'test123' }, confirmed_at: Time.now }.to_json, headers: { 'Content-Type': 'application/json', Accept: 'application/json' }
      # binding.pry
      expect(response.body).to eq("Thank you for joining Oivan platform, please check your email and verify your account!")
    end

    it "login a user" do
      user = create(:user, :with_confirmed_email)
      post '/api/users/login', params: { user: { email: user.email, password: user.password } }
      # binding.pry
      expect(response).to have_http_status(200)
      # expect(response.body).to include("access-token")
    end
  end
end
