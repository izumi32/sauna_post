require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
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
end
