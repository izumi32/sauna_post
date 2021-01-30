require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "ホームのリンク" do
    get root_url
    assert_select "a[href=?]", root_url
    assert_select "a[href=?]", signup_path, count: 2
  end
end
