require 'spec_helper'

describe "PasswordResets" do
  it "emails user when requesting password reset" do
  	user = create(:user)
  	visit login_url
  	click_link "password"
  	fill_in "Email", with: user.email
  	click_button "Reset Password"
  end
end
