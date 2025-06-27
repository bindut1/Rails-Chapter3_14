require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  test "should be valid with valid content and user" do
    assert @micropost.valid?
  end

  test "should be invalid without user id" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "should be invalid with blank content" do
    @micropost.content = " "
    assert_not @micropost.valid?
  end

  test "should be invalid with content longer than 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  test "should return most recent micropost first" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end
