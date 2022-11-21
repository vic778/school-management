# require "rails_helper"

# RSpec.feature "User signs in" do
def sign_in_teacher
  user = create(:user, :with_confirmed_email)
  post '/api/users/login', params: { user: { email: user.email, password: user.password } }
  res = JSON.parse(response.body)
  res["user"]
end
# end
