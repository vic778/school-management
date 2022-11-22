RSpec.describe "Sessions", type: :request do
  it "login a user" do
    user = create(:user, :with_confirmed_email)
    post '/api/users/login', params: { user: { email: user.email, password: user.password } }
    # binding.pry
    expect(response).to have_http_status(200)
    # expect(response.body).to include("access-token")
  end
end
