require "test_helper"

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:michael)
    remember(@user)
  end

  test "should return current user when session is nil and remember token is valid" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "should return nil when remember digest is invalid" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end
