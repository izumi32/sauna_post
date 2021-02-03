require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "無効なユーザーのログイン" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "有効なユーザーのログイン/ログアウト" do
    get login_path
    log_in @user
    assert logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    delete logout_path
    assert_not logged_in?
    assert_redirected_to root_url
    delete logout_path
  end

  test "永続的セッションを維持してログイン" do
    log_in @user, remember_me: '1'
    assert_not_empty cookies[:remember_token]
  end

  test "永続的セッションを維持せずログイン" do
    log_in @user, remember_me: '1'
    delete logout_path
    log_in @user, remember_me: '0'
    assert_empty cookies[:remember_token]
  end
end
