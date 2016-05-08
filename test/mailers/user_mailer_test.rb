require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:matt)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account Activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@bookmrks.io"], mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

  test "password reset" do
    user = users(:matt)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Password Reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@bookmrks.io"], mail.from
    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end
end