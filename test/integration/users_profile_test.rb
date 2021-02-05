require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "プロフィールページ" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1 > img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.name, response.body
      assert_match micropost.address, response.body
      assert_match micropost.price.to_s, response.body
      assert_match micropost.evaluate.to_s, response.body
    end
  end
end
