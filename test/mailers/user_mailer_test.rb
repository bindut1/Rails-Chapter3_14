require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "should send account activation email with correct content" do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation", mail.subject
    assert_equal [ user.email ], mail.to
    assert_equal [ ENV["GMAIL_USERNAME"] || "noreply@example.com" ], mail.from
    assert_match user.name, mail.body.encoded
    assert_match user.activation_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end

  test "should send password reset email with correct content" do
    user = users(:michael)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Password reset", mail.subject
    assert_equal [ user.email ], mail.to
    assert_equal [ ENV["GMAIL_USERNAME"] || "noreply@example.com" ], mail.from
    assert_match user.reset_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end
end
