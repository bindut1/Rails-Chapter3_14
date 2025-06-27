require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "should render login form again with flash when information is invalid" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: {
      session: {
        email: "",
        password: ""
      }
    }
    assert_template "sessions/new"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "should not log in with valid email and invalid password" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: {
      session: {
        email: @user.email,
        password: "invalid"
      }
    }
    assert_not is_logged_in?
    assert_template "sessions/new"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "should log in with valid info and then log out" do
    get login_path
    post login_path, params: {
      session: {
        email: @user.email,
        password: "password"
      }
    }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "should log in with remembering" do
    log_in_as(@user, remember_me: "1")
    assert_equal cookies[:remember_token], assigns(:user).remember_token
  end

  test "should log in without remembering" do
    log_in_as(@user, remember_me: "1")
    log_in_as(@user, remember_me: "0")
    assert_empty cookies[:remember_token]
  end
end
