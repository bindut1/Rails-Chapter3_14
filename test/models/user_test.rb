require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: "Example User",
      email: "user@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "should be invalid when name is blank or too long" do
    @user.name = " "
    assert_not @user.valid?, "name should be invalid when blank"

    @user.name = "a" * 51
    assert_not @user.valid?, "name should be invalid when too long"
  end

  test "should validate email presence, length, and format" do
    @user.email = "   "
    assert_not @user.valid?, "email should be invalid when blank"

    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?, "email should be invalid when too long"

    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end

    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com user@.com @example.com
                           user@example. user@-example.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "should not allow duplicate email addresses" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?, "duplicate email should be invalid"
  end

  test "should save email addresses as lowercase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "should be invalid when password is blank or too short" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?, "password should be invalid when blank"

    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?, "password should be invalid when too short"
  end

  test "should return false from authenticated? when digest is nil" do
    assert_not @user.authenticated?(:remember, ""), "authenticated? should return false when digest is nil"
  end
end
