require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "非ログイン時indexにリダイレクト" do
    get users_path
    assert_redirected_to login_url
  end

  test "非ログイン時editにリクエスト" do
    get edit_user_path @user
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "非ログイン時updateにリクエスト" do
    patch user_path @user, params: { user: { name: "valid user",
                                             email: "user@valid.com",
                                             password: "",
                                             password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "別のユーザーでのログイン時editにリクエスト" do
    log_in @other_user
    get edit_user_path @user
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "別のユーザーでのログイン時updateにリクエスト" do
    log_in @other_user
    patch user_path @user, params: { user: { name: "valid user",
                                             email: "user@valid.com" } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "非ログイン時destroyにリクエスト" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "権限のないユーザーでのログイン時にdestroyにリクエスト" do
    log_in @other_user
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
end
