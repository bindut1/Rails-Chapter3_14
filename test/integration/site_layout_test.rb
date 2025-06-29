require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "should display layout links and correct title on contact page" do
    get root_path
    assert_template "static_pages/home"
    assert_select "a[href=?]", root_path, count: 1
    assert_select "a[href=?]", help_static_pages_path
    assert_select "a[href=?]", about_static_pages_path
    assert_select "a[href=?]", contact_static_pages_path
    get contact_static_pages_path
    assert_select "title", full_title("Contact")
  end
end
