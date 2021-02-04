require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = users(:michael)
    @non_admin_user = users(:archer)
  end

  test "権限のあるユーザーでindexにリクエスト" do
    log_in @admin_user
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin_user
        assert_select 'a[href=?]', user_path(user), text: "削除"
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin_user)
    end
  end

  test "権限のないユーザーでindexにリクエスト" do
    log_in @non_admin_user
    get users_path
    assert_select 'a', text: "削除", count: 0
  end
end
