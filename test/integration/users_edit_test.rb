require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "無効なユーザー編集" do
    log_in @user
    get edit_user_path @user
    assert_template 'users/edit'
    patch user_path @user, params: { user: { name: "",
                                              email: "foo@invalid",
                                              password: "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
  end

  test "有効なユーザー編集" do
    get edit_user_path @user
    log_in @user
    assert_redirected_to edit_user_path @user
    name = "valid user"
    email = "user@valid.com"
    patch user_path @user, params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
