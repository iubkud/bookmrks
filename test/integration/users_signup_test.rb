require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup info" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    #assert_template 'users/new'
    parsed_response = JSON.parse(@response.body)
    assert_equal "false", parsed_response['created']
  end

  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path user: { name:  "Example User",
                              email: "user@example.com",
                              password:              "password",
                              password_confirmation: "password" }
    end
    parsed_response = JSON.parse(@response.body)
    assert_equal "true", parsed_response['created'] 
  end
end
