require "test_helper"
class ApplicationHelperTest < ActionView::TestCase
  BASE_TITLE = "Ruby on Rails Tutorial Sample App"
  test "full title helper" do
    assert_equal full_title, BASE_TITLE
    assert_equal full_title("Help"), "Help | " + BASE_TITLE
  end
end
